module ClickUp
  class AddNewTaskToTheBacklog
    include Command::Message

    attribute :tid, String
    attribute :title, String
    attribute :description, String

    validates :tid, :title, presence: true
  end
end

module ClickUp
  class Service
    include Command::Handler
    handles AddNewTaskToTheBacklog, :add_new_task

    private

    def add_new_task(cmd)
      Rails.configuration.clickup.add_task(title: cmd.title, description: cmd.description)
    end
  end
end
