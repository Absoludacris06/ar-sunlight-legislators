# require_relative '../config'

class CreateLegislators < ActiveRecord::Migration

  def change
    create_table :legislators do |t|
      t.string :state
      t.string :title
      t.string :name
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :party
      t.integer :in_office
      t.string :gender
      t.date :birthdate
      t.string :twitter_id
    end

  end

end
