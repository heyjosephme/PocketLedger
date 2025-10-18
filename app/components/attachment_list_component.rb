class AttachmentListComponent < ViewComponent::Base
  def initialize(attachments:)
    @attachments = attachments
  end

  def attachments
    @attachments
  end
end
