class @OtherDigitalClock extends DigitalClock

  @onDOM '.up-seconds', 'click', 'upSeconds'
  @onDOM '.down-seconds', 'click', 'downSeconds'
  
  @className: 'digital-other'

  template: -> template['other_digital_clock']
