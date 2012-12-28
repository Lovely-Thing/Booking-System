module StateMachineExt

  States = {
    pending_stylist_approval: 0,
    pending_client_approval: 1,
    confirmed: 2,
    canceled: 3
  }

  
  def status
  	retval = ''
  	if pending_stylist_approval? 
  		retval = 'Pending Stylist Approval'
  	elsif pending_client_approval?
  		retval = 'Pending Client Approval'
  	elsif confirmed?
  		retval = 'Confirmed'
  	elsif canceled?
  		retval = 'Canceled'
  	end
  	retval
  end
end
