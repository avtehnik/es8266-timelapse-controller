function flash(pin)
  gpio.write(pin, gpio.HIGH)
  tmr.delay(10)
  gpio.write(pin, gpio.LOW)
end