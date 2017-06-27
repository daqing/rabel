class CreateChannels < ActiveRecord::Migration[4.2]
  def change
    create_table :channels do |t|
      t.string :name

      t.timestamps null: false
    end

    Node.find_each do |node|
      Channel.create(name: node.name)
    end
  end
end
