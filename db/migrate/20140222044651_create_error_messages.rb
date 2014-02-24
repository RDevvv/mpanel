class CreateErrorMessages < ActiveRecord::Migration
    def up
        create_table :error_messages do |t|
            t.text :class_name
            t.text :message
            t.text :trace
            t.text :params
            t.text :target_url
            t.text :referer_url
            t.text :user_agent
            t.string :user_info
            t.string :app_name
            t.string :doc_root

            t.timestamps
        end
    end

    def down
        drop_table :error_messages
    end
end
