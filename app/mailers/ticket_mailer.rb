class TicketMailer < ApplicationMailer
  def ticket_email(ticket)
    @ticket = ticket

    @users = User.with_role(:admin)

    arr = Array.new

    @users.each do |user|
      arr << user.email
    end

   mail(to: arr, subject: 'Ticket Created')
  end
end
