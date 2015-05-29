require 'gir_ffi'

GirFFI.setup :Atspi
Atspi.load_class :Accessible

# Utility monkey-patches for the Atspi::Accessible class
module AtspiAccessiblePatches
  def each_child
    child_count.times do |i|
      child = get_child_at_index i
      yield child if child
    end
  end

  def find_role(role, regex = //)
    return self if role == self.role && name =~ regex
    each_child do |child|
      result = child.find_role role, regex
      return result if result
    end
    nil
  end

  def inspect_recursive(level = 0, maxlevel = 4)
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
  def initialize(app_name, verbose: false)
    @app_file = "bin/#{app_name}"
    @lib_dir = 'lib'
    @app_name = app_name
    @pid = nil
    @verbose = verbose
  end

  def boot(test_timeout: 30, exit_timeout: 10, arguments: [])
    raise 'Already booted' if @pid

    spawn_process(arguments)

    @cleanup = false

    @thread = Thread.new do
      wait_for('test to be done', test_timeout) { @cleanup }
      wait_for('pid to go away', exit_timeout) { !@pid }
      kill_process if @pid
    end
  end

  def spawn_process(arguments)
    command = "ruby -I#{@lib_dir} #{@app_file} #{arguments.join(' ')}"
    log "About to spawn: `#{command}`"
    @pid = Process.spawn command
  end

  def press_ctrl_q
    Atspi.generate_keyboard_event(37, nil, :press)
    Atspi.generate_keyboard_event(24, nil, :pressrelease)
    Atspi.generate_keyboard_event(37, nil, :release)
  end

  def cleanup
    status = exit_status
    @pid = nil
    @thread.join if @thread
    status
  end

  def find_and_focus_frame
    acc = wait_for('app to appear', 10) { find_app }
    raise 'App not found' unless acc

    frame = acc.get_child_at_index 0
    frame.role.must_equal :frame
    frame.grab_focus
    sleep 0.1

    frame
  end

  private

  def kill_process
    log "About to kill child process #{@pid}"
    Process.kill 'KILL', @pid
  end

  def log(message)
    warn message if @verbose
  end

  def find_app
    desktop = Atspi.get_desktop(0)
    desktop.each_child do |child|
      return child if child.name == @app_name
    end
    nil
  end

  # TODO: User timeout
  def wait_for(description, _timeout)
    start = Time.now
    # Try for 0.01 * 50 * (50 + 1) / 2 = 12.75 seconds
    value = 50.times.each do |num|
      result = yield
      break result if result
      sleep 0.01 * (num + 1)
    end
    log "Waited #{Time.now - start} seconds for #{description}"
    value
  end

  def exit_status
    return unless @pid
    @cleanup = true
    _, status = Process.wait2 @pid
    status
  end
end
