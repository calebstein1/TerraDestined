function init_music()
    music_tracks={-1,2,4,0,2,4,-1,-1,2,2,-1,-1}
    music_playing=false
end

function play_music_for_location()
    if not music_playing and frame-map_changed>=30 then
        music_playing=true
        music(music_tracks[p_map],500)
        music(-1)
    end
end

function play_music(t,f)
    if not music_playing then
        music_playing=true
        music(t,f)
    end
end

function stop_music()
    music_playing=false
    music(-1,500)
end