$ ->
  # movie_id = gon.movie_id
  # $('#history_year').change ->
  #   $.get '/histories/months', {movie_id: movie_id, year: $(this).val()}, (json)->
  #     $('#history_month').empty()
  #     $('#history_day').prop('disabled', true)
  #     $('#history_hour').prop('disabled', true)
  #     $('#history_minute').prop('disabled', true)
  #     $('#jump_to_history_time').prop('disabled', true)
  #     options = $.map json, (value)->
  #       $('<option>').val(value).text(value)
  #     $('#history_month').append(options)

  # $('#history_month').change ->
  #   $.get '/histories/days', {movie_id: movie_id, year: $('#history_year').val(), month: $(this).val()}, (json)->
  #     $('#history_day').empty()
  #     $('#history_hour').prop('disabled', true)
  #     $('#history_minute').prop('disabled', true)
  #     $('#jump_to_history_time').prop('disabled', true)
  #     options = $.map json, (value)->
  #       $('<option>').val(value).text(value)
  #     $('#history_day').append(options)
  class TimeParts
    @parts = ['minute', 'hour', 'day', 'month', 'year']
    constructor: (@change_part)->

    next_part: ->
      now = null
      for p in TimeParts.parts
        if p == @change_part
          return now
        else
          now = p

    disable_parts: ->
      change_index = TimeParts.parts.indexOf @change_part
      TimeParts.parts[0..change_index-2]

    able_parts: ->
      change_index = TimeParts.parts.indexOf @change_part
      TimeParts.parts[change_index-1..-1]

    params: ->
      params = {movie_id: gon.movie_id}
      for p in TimeParts.parts
        params[p] = $("#history_#{p}").val()
      params


  for part in TimeParts.parts[1..-1]
    time_part = new TimeParts part
    $("#history_#{time_part.change_part}").change {time_part: time_part}, (event)->
      time_part = event.data.time_part
      next_part = time_part.next_part()
      $.get "/histories/#{next_part}s", time_part.params(), (json)->
        for p in time_part.disable_parts()
          $("#history_#{p}").prop('disabled', true)
        for p in time_part.able_parts()
          $("#history_#{p}").prop('disabled', false)
        if next_part == 'minute'
          $('#jump_to_history_time').prop('disabled', false)
        else
          $('#jump_to_history_time').prop('disabled', true)
        $("#history_#{next_part}").empty()
        options =  json.map (value)->
          $('<option>').val(value).text(value)
        $("#history_#{next_part}").append(options)




