# frozen_string_literal: true

require 'fiddle/import'
require 'auto_click/input_structure'
require 'auto_click/virtual_key'
require 'auto_click/user32'

module AutoClick
  @@rightdown = InputStructure.mouse_input(0, 0, 0, 0x0008)
  @@rightup = InputStructure.mouse_input(0, 0, 0, 0x0010)
  @@leftdown = InputStructure.mouse_input(0, 0, 0, 0x0002)
  @@leftup = InputStructure.mouse_input(0, 0, 0, 0x0004)
  @@middledown = InputStructure.mouse_input(0, 0, 0, 0x0020)
  @@middleup = InputStructure.mouse_input(0, 0, 0, 0x0040)

  def input_send(inputs)
    n = inputs.size
    ptr = inputs.collect(&:to_s).join
    User32.SendInput(n, ptr, inputs[0].size)
  end

  def screen_resolution
    screen = Array.new(2)
    usr32 = Fiddle.dlopen('user32')
    gsm = Fiddle::Function.new(usr32['GetSystemMetrics'], [Fiddle::TYPE_LONG], Fiddle::TYPE_LONG)
    screen[0] = gsm.call(0)
    screen[1] = gsm.call(1)
    screen
  end

  def mouse_set(x, y)
    User32.SetCursorPos(x, y)
  end

  def mouse_Pset(x, y)
    screen = screen_resolution
    x = x.to_f
    y = y.to_f

    desX = (screen[0] * (x / 100.0)).to_f
    desY = (screen[1] * (y / 100.0)).to_f
    desX = desX.round
    desY = desY.round

    User32.SetCursorPos(desX, desY)
  end

  def mouse_Pmove(x, y)
    screen = screen_resolution
    x = x.to_f
    y = y.to_f

    desX = (screen[0] * (x / 100.0)).to_f
    desY = (screen[1] * (y / 100.0)).to_f
    desX = desX.round
    desY = desY.round

    currentX = mouse_position[0]
    currentY = mouse_position[1]

    while currentX != desX
      currentX = if currentX < desX
                   mouse_position[0] + 1
                 else
                   mouse_position[0] - 1
                 end
      mouse_set(currentX, currentY)
      sleep(0.0012)
    end

    while currentY != desY
      currentY = if currentY < desY
                   mouse_position[1] + 1
                 else
                   mouse_position[1] - 1
                 end
      mouse_set(currentX, currentY)
      sleep(0.0012)
    end
    puts("FINAL POSITION: \nx:" + currentX.to_s + ' Y:' + currentY.to_s)
  end

  def mouse_move(x, y)
    currentX = mouse_position[0]
    currentY = mouse_position[1]
    desX = y
    desY = x

    while currentX != desX
      currentX = if currentX < desX
                   mouse_position[0] + 1
                 else
                   mouse_position[0] - 1
                 end
      mouse_set(currentX, currentY)
      sleep(0.0012)
    end

    while currentY != desY
      currentY = if currentY < desY
                   mouse_position[1] + 1
                 else
                   mouse_position[1] - 1
                 end
      mouse_set(currentX, currentY)
      sleep(0.0012)
    end
    # puts("FINAL POSITION: \nx:"+ currentX.to_s + " Y:"+ currentY.to_s)
  end

  def mouse_Rclick
    input_send([@@rightdown, @@rightup])
  end

  def mouse_Lclick(num)
    i = 0
    while i < num
      input_send([@@leftdown, @@leftup])
      i += 1
      sleep(0.001)
    end
  end

  def mouse_Mclick
    input_send([@@middledown, @@middleup])
  end

  def mouse_down(button_name)
    case button_name
    when :right
      input_send([@@rightdown])
    when :middle
      input_send([@@middledown])
    else
      input_send([@@leftdown])
    end
  end

  def mouse_up(button_name)
    case button_name
    when :right
      input_send([@@rightup])
    when :middle
      input_send([@@middleup])
    else
      input_send([@@leftup])
    end
  end

  def mouse_position
    point = ' ' * 8
    User32.GetCursorPos(point)
    point.unpack('LL')
  end

  def mouse_scroll(d)
    scroll = InputStructure.mouse_input(0, 0, d * 120, 0x0800)
    input_send([scroll])
  end

  def mouse_Ldrag(sx, sy, ex, ey)
    mouse sx, sy
    sleep 0.1
    input_send([@@leftdown])
    sleep 0.1
    mouse ex, ey
    sleep 0.1
    input_send([@@leftup])
    sleep 0.1
  end

  def mouse_Rdrag(sx, sy, ex, ey)
    mouse sx, sy
    sleep 0.1
    input_send([@@rightdown])
    sleep 0.1
    mouse ex, ey
    sleep 0.1
    input_send([@@rightup])
    sleep 0.1
  end

  def key_stroke(key_name)
    code = VirtualKey.code_from_name(key_name)
    input_send([InputStructure.keyboard_input(code, 0x0000),
                InputStructure.keyboard_input(code, 0x0002)])
  end

  def key_down(key_name)
    code = VirtualKey.code_from_name(key_name)
    input_send([InputStructure.keyboard_input(code, 0x0000)])
  end

  def key_up(key_name)
    code = VirtualKey.code_from_name(key_name)
    input_send([InputStructure.keyboard_input(code, 0x0002)])
  end

  def keyboard(string)
    key_stroke(:capslock) if key_state(:capslock) == 1
    string = string.to_s
    string.each_char do |c|
      sleep(0.12)
      if ('a'..'z').cover? c
        key_stroke(c.to_sym)
      elsif ('A'..'Z').cover? c
        key_down(:leftshift)
        key_stroke(c.to_sym)
        key_up(:leftshift)
      elsif ('0'..'9').cover? c
        key_stroke(('num' + c).to_sym)
      else
        case c
        when ' '
          key_stroke(:space)
        when ';'
          key_stroke(:semicolon)
        when ':'
          key_down(:leftshift)
          key_stroke(:semicolon)
          key_up(:leftshift)
        when '='
          key_stroke(:equal)
        when '+'
          key_down(:leftshift)
          key_stroke(:plus)
          key_up(:leftshift)
        when ','
          key_stroke(:comma)
        when '<'
          key_down(:leftshift)
          key_stroke(:smallerthan)
          key_up(:leftshift)
        when '-'
          key_stroke(:hyphen)
        when '_'
          key_down(:leftshift)
          key_stroke(:underscore)
          key_up(:leftshift)
        when '.'
          key_stroke(:period)
        when '>'
          key_down(:leftshift)
          key_stroke(:greaterthan)
          key_up(:leftshift)
        when '/'
          key_stroke(:slash)
        when '?'
          key_down(:leftshift)
          key_stroke(:question)
          key_up(:leftshift)
        when '`'
          key_stroke(:grave)
        when '~'
          key_down(:leftshift)
          key_stroke(:tilde)
          key_up(:leftshift)
        when '/'
          key_stroke(:slash)
        when '?'
          key_down(:leftshift)
          key_stroke(:question)
          key_up(:leftshift)
        when '['
          key_stroke(:branket)
        when '{'
          key_down(:leftshift)
          key_stroke(:branket)
          key_up(:leftshift)
        when ']'
          key_stroke(:closebranket)
        when '}'
          key_down(:leftshift)
          key_stroke(:closebranket)
          key_up(:leftshift)
        when '\\'   # You need to esapce \ in the parameter string
          key_stroke(:backslash)
        when '|'
          key_down(:leftshift)
          key_stroke(:pipe)
          key_up(:leftshift)
        when '\''   # escape ' only for single quote string
          key_stroke(:quote)
        when '"'    # escape " only for double quote string
          key_down(:leftshift)
          key_stroke(:doublequote)
          key_up(:leftshift)
        when '!'
          key_down(:leftshift)
          key_stroke(:num1)
          key_up(:leftshift)
        when '@'
          key_down(:leftshift)
          key_stroke(:num2)
          key_up(:leftshift)
        when '#'    # The sharp sign need to be escape in single quote string
          key_down(:leftshift)
          key_stroke(:num3)
          key_up(:leftshift)
        when '$'
          key_down(:leftshift)
          key_stroke(:num4)
          key_up(:leftshift)
        when '%'
          key_down(:leftshift)
          key_stroke(:num5)
          key_up(:leftshift)
        when '^'
          key_down(:leftshift)
          key_stroke(:num6)
          key_up(:leftshift)
        when '&'
          key_down(:leftshift)
          key_stroke(:num7)
          key_up(:leftshift)
        when '*'
          key_down(:leftshift)
          key_stroke(:num8)
          key_up(:leftshift)
        when '('
          key_down(:leftshift)
          key_stroke(:num9)
          key_up(:leftshift)
        when ')'
          key_down(:leftshift)
          key_stroke(:num0)
          key_up(:leftshift)
        end

      end
    end
  end

  def key_state(key_name)
    code = VirtualKey.code_from_name(key_name)
    User32.GetKeyState(code)
    # For normal keys (such as a)
    # When the key is down the value is -128
    # When the key is up the value is 0

    # For toggle keys (such as capslock)
    # When the cap key is down and the caplock is on the value is -127
    # When the cap key is down and the caplock is off the value is -128
    # When the cap key is Up and the caplock is on the value is 1
    # When the cap key is Up and the caplock is off the value is 0
  end
end

include AutoClick # This line allow auto include when the user require the gem
