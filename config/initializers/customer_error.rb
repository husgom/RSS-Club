ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    if instance.error_message.kind_of?(Array)
      %(<div class="fieldWithErrors">#{html_tag}</div><span class="validation-error">&nbsp;  #{instance.error_message.join(',')}</span>)
    else
      %(<div class="fieldWithErrors">#{html_tag}</div><span class="validation-error">&nbsp;  #{instance.error_message}</span>)
    end
 end