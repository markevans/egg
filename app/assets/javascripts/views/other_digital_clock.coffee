class @OtherDigitalClock extends DigitalClock

  @onDOM 'click', '.up-seconds', 'upSeconds'
  @onDOM 'click', '.down-seconds', 'downSeconds'
  
  template: -> template['other_digital_clock']
