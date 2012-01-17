class @OtherDigitalClock extends DigitalClock

  @onDOM 'click', '.up-seconds', 'upSeconds'
  @onDOM 'click', '.down-seconds', 'downSeconds'
  
  @className: 'digital-other'

  template: -> template['other_digital_clock']
