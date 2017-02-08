class MessageDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_message_path

  def sortable_columns
    @sortable_columns ||= [
      'Message.id',
      'Message.name',
      'Message.subject',
      'Message.send_when_accepted'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'Message.id',
      'message.name',
      'Message.subject',
      'Message.recipients'
    ]
  end

  private

  def data
    records.map do |record|
      [
        link_to('<i class="fa fa-search"></i>'.html_safe, manage_message_path(record)),
        record.id,
        record.name,
        record.subject,
        record.send_when_accepted ? '<span style="color: red;">Yes</span>' : '-',
        record.status.titleize
      ]
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    Message.unscoped
  end
end
