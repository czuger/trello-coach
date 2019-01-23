class ReminderMailer < ApplicationMailer

  def send_reminder
    @user = params[:user]
    @nb_days = params[:nb_days]
    mail(to: @user[:email], subject: 'Rappel : tâches') do |format|
      format.text
    end
  end

end
