# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160219191135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asignaturas", force: :cascade do |t|
    t.string   "name"
    t.boolean  "lectiva"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cursos", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horarios", force: :cascade do |t|
    t.decimal  "horas"
    t.integer  "professor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "curso_id"
    t.integer  "asignatura_id"
  end

  add_index "horarios", ["asignatura_id", "curso_id"], name: "index_horarios_on_asignatura_id_and_curso_id", unique: true, using: :btree
  add_index "horarios", ["asignatura_id"], name: "index_horarios_on_asignatura_id", using: :btree
  add_index "horarios", ["curso_id"], name: "index_horarios_on_curso_id", using: :btree
  add_index "horarios", ["professor_id"], name: "index_horarios_on_professor_id", using: :btree

  create_table "professors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "horarios", "asignaturas"
  add_foreign_key "horarios", "cursos"
  add_foreign_key "horarios", "professors"
end
