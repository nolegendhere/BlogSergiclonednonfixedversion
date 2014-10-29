class CreateCalendarMonthYears < ActiveRecord::Migration
  def change
    create_table :calendar_month_years do |t|
	  t.datetime "month_post"
	  t.datetime "year_post"	
      t.timestamps 
    end
  end
end
