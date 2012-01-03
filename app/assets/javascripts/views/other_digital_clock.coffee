class @OtherDigitalClock extends DigitalClock

  @on 'click', '.up-seconds', 'upSeconds'
  @on 'click', '.down-seconds', 'downSeconds'
  
  template: -> template['other_digital_clock']
