require 'gir_ffi'

GirFFI.setup :Atspi
Atspi.load_class :Accessible

# Utility monkey-patches for the Atspi::Accessible class
module AtspiAccessiblePatches
  def each_child
    child_count.times do |i|
      yield get_child_at_index i
    end
  end

  def find_role role, regex = //
    return self if role == self.role && name =~ regex
    each_child do |child|
      result = child.find_role role, regex
      return result if result
    end
    nil
  end

  def inspect_recursive level = 0, maxlevel = 4
    each_child do |child|
      puts "#{'  ' * level} > name: #{child.name}; role: #{child.role}"
      child.inspect_recursive(level + 1) unless level >= maxlevel
    end
  end
end

Atspi::Accessible.include AtspiAccessiblePatches

# Test driver for the Atspi-enabled applications. Takes care of boot and
# shutdown, and provides a handle on the GUI's main UI frame.
class AppDriver
  def initialize app_name
    @app_file = "bin/#{app_name}"
    @lib_dir = 'lib'
    @app_name = app_name
    @pid = nil
    @killed = false
  end

  def boot test_timeout: 30, exit_timeout: 10, arguments: []
    raise 'Already booted' if @pid
    warn "About to spawn: `ruby -I#{@lib_dir} #{@app_file} #{arguments.join(' ')}`"
    @pid = Process.spawn "ruby -I#{@lib_dir} #{@app_file} #{arguments.join(' ')}"

    @killed = false
    @cleanup = false

    Thread.new do
      count = 0
      (test_timeout * 10).times do
        count += 1
        break if @cleanup
        sleep 0.1
      end
      warn "Waited #{count * 0.1} seconds for test to be done"

      count = 0
      (exit_timeout * 10).times do
        count += 1
        break unless @pid
        sleep 0.1
      end
      warn "Waited #{count * 0.1} seconds for pid to go away"

      if @pid
        warn "About to kill child process #{@pid}"
        @killed = true
        Process.kill 'KILL', @pid
      end
    end
  end

  def press_ctrl_q
    Atspi.generate_keyboard_event(37, nil, :press)
    Atspi.generate_keyboard_event(24, nil, :pressrelease)
    Atspi.generate_keyboard_event(37, nil, :release)
  end

  def cleanup
    return unless @pid
    @cleanup = true
    _, status = Process.wait2 @pid
    @pid = nil
    status
  end

  def find_and_focus_frame
    acc = try_repeatedly { find_app @app_name }
    raise "App not found" unless acc

    frame = acc.get_child_at_index 0
    frame.role.must_equal :frame
    frame.grab_focus
    sleep 0.1

    frame
  end

  private

  def find_app name
    desktop = Atspi.get_desktop(0)
    desktop.each_child do |child|
      next if child.nil?
      return child if child.name == name
    end
    nil
  end

  def try_repeatedly
    # Try for about 12 seconds
    50.times.each do |num|
      result = yield
      return result if result
      sleep_time = 0.01 * (num + 1)
      sleep sleep_time
    end
    yield
  end
end
