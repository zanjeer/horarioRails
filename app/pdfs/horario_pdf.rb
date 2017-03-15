include ActionView::Helpers::NumberHelper # <-
class HorarioPdf < Prawn::Document

  def initialize(profes, profes_jefes)
    super(top_margin: 30)
    move_down 20
    # text "Profesores:", :align => :left
    profes_jefes.each do |profe|
      text "Carga Horaria 2017", :align => :center
      profes_info(profe,true)
      start_new_page
    end
    move_down 10
    profes.each do |profe|
      text "Carga Horaria 2017", :align => :center
      profes_info(profe,false)
      start_new_page
    end
  end

  def profes_info(p,jefe)
    move_down 10
    table profes_info_row(p,jefe) do
      row(0).font_style = :bold
      column(1).align = :right
      self.row_colors = ["FFFFFF","EEEEEE"]
      # self.header = true
      self.width = 400
      column(0).width = 150
    end
    move_down 10

  end

  # estructura del pdf
  def profes_info_row(p,jefe)
    [[{:content => "#{p.name}", :colspan => 2}]] +
    # es_profe_jefe(p) +
    [["Contrato", "#{p.contrato}"]] +
    # asignaturas_profe(p,jefe) +
    asignaturas_peda_por(p) +
    [["Total Horas Pedagogicas" , horas_pedagogicas(p)]] +
     asignaturas_no_peda(p) +
    [["Total Horas Cronologicas", horas_cronologicas(p)]]
  end


  # asignaturas lectivas por curso de profe
  # format:  nombre - curso => horas
  def asignaturas_peda_por(profe)
    # per = Horario.where('professor_id = ?', profe.id).joins(:asignatura).where('lectiva=true')
    per = Horario.where('professor_id = ?', profe.id).joins(:asignatura)
    .where('asignaturas.lectiva=TRUE').order('asignaturas.orden')
    a = per.map do |h|
      ["#{h.asignatura.name} #{h.curso.name} ", "#{h.horas}"]
    end

  end


  def asignaturas_no_peda(profe)
    per = Horario.where('professor_id = ?', profe.id).joins(:asignatura)
    .where('asignaturas.lectiva=FALSE').order('asignaturas.orden')
      a = per.map do |h|
        ["#{h.asignatura.name}","#{h.horas}"]
      end
      # ordena la wea como el pico
      a.sort

  end


  def horas_pedagogicas(profe)
    # busca los horarios donde las asignaturas sean lectivas por profe
    per = Horario.where('professor_id = ?', profe.id).joins(:asignatura).where('lectiva=true')
    per.sum(:horas)
  end

  def horas_cronologicas(profe)
    # horas pedagogicas llegan como string
    total = to_time( (horas_pedagogicas(profe)*45).to_f/60 ).to_d
    a = Horario.where('professor_id = ?', profe.id).joins(:asignatura).where('lectiva=false')
    # total = "#{a.sum(:horas)} + #{total} = #{a.sum(:horas) + total}"
    # total += a.sum(:horas)
    total += to_hora( a.sum(:horas) )
  end

  def horas_peda_por_asignatura(id_profe, id_asig)
    per = Horario.where('professor_id = ? AND asignatura_id= ?', id_profe, id_asig)
    per.sum(:horas)
  end

  def asignaturas_profe(profe,jefe)
    asi = Horario.where('professor_id = ?', profe.id)
    asi.map(&:asignatura).uniq.map do |a|
      if a.lectiva
        # if jefe
        #   ["#{a.name}", "#{horas_peda_por_asignatura(profe.id,a.id)} " ]
        # else
          ["#{a.name}", "#{lista_cursos_por_asig(a.id,profe.id)} => #{horas_peda_por_asignatura(profe.id,a.id)} " ]
        # end
      else
        ["#{a.name}", "#{horas_peda_por_asignatura(profe.id,a.id)}"]
      end
    end
  end

  def lista_cursos_por_asig(a_id,p_id)
    asi = Horario.where('professor_id = ? AND asignatura_id = ?', p_id, a_id)
    cursos = ""
    asi.each do |a|
      cursos << " #{a.curso.name} "
    end
    cursos
  end

  # change number to time
  # 2.75% => 2.45min
  def to_time(number)
    n = number.to_s.split(".") # 1.25 [0]=> 1, [1]=> 25
    num = n[0]
    dec = n[1]
    case dec
    when "75"
      final_number = "#{num}.45"
    when "5"
      final_number = "#{num}.30"
    when "25"
      final_number = "#{num}.15"
    else
      final_number = number
    end
  end

  def to_hora(number)
    n = number.to_s.split(".") # 1.25 [0]=> 1, [1]=> 25
    hora = n[0].to_i
    min = n[1].to_i
    while $min >= 6 do
      $min = $min - 6
      $hora +=1
    end
    final = "#{hora}.#{min}"
  end

  def es_profe_jefe(profe)
    a = Curso.find_by(professor_id: profe.id)
    if a
      [["Curso Jefatura","#{a.name}."]]
    else
      [["Curso Jefatura", "-"]]
    end
  end


end
