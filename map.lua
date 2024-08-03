--[[
0 combat
1 indoor house
2 first town
3 east cave
4 game over/main menu
5 southern woods
6 west cave
7 hilltop
8 snow forest
9 forest village
10 deep forest
11 cult camp
]]

map_d={
    [0]={
        x_start=0,
        x_end=128,
        y_start=0,
        y_end=128
    },
    -- 1
    {
        x_start=272,
        x_end=400,
        y_start=0,
        y_end=128
    },
    -- 2
    {
        x_start=0,
        x_end=272,
        y_start=0,
        y_end=224
    },
    -- 3
    {
        x_start=272,
        x_end=400,
        y_start=128,
        y_end=352
    },
    -- 4
    {
        x_start=400,
        x_end=528,
        y_start=0,
        y_end=128
    },
    -- 5
    {
        x_start=0,
        x_end=272,
        y_start=224,
        y_end=352
    },
    -- 6
    {
        x_start=272,
        x_end=400,
        y_start=352,
        y_end=512
    },
    -- 7
    {
        x_start=400,
        x_end=528,
        y_start=384,
        y_end=512
    },
    -- 8
    {
        x_start=400,
        x_end=528,
        y_start=128,
        y_end=400
    },
    -- 9
    {
        x_start=144,
        x_end=272,
        y_start=336,
        y_end=512
    },
    -- 10
    {
        x_start=0,
        x_end=144,
        y_start=336,
        y_end=512
    },
    -- 11
    {
        x_start=400,
        x_end=528,
        y_start=0,
        y_end=128
    }
}
map_bg={4,11,5,0,11,5,11,7,11,11,11}

function connected_map_warp()
    if p_state==3 then
        return
    end
    if p_map==2 and p_y>224 then
        set_map(5)
    elseif p_map==5 then
        if p_y<216 then
            set_map(2)
        elseif p_y>352 then
            set_map(9)
        end
    elseif p_map==7 and p_y<384 then
        stop_music()
        set_map(8)
    elseif p_map==8 and p_y>400 then
        stop_music()
        set_map(7)
    elseif p_map==9 then
        if p_y<344 then
            set_map(5)
        elseif p_x<136 then
            set_map(10)
        end
    elseif p_map==10 then
        if p_x>144 then
            set_map(9)
        end
    end
end

function set_map(n)
    p_map=n
    map_changed=frame
end

function set_warp()
    if p_map==0 then
        return
    elseif p_map==1 then
        local sm_x={8,12,28,22,30}
        local sm_y={2,17,9,55,55}
        p_wm=2
        p_wx=sm_x[p_submap]
        p_wy=sm_y[p_submap]
    elseif p_map==2 then
        --[[
        Default to house interior
        Individual warps will override values as needed
        ]]
        p_wx=42
        p_wy=14
        p_wm=1
        if p_x<16 then
            p_wx=48
            p_wy=57
            p_wm=6
        elseif p_x<80 then
            p_submap=1
        elseif p_x<112 then
            p_submap=2
        elseif p_x<240 then
            p_submap=3
        else
            p_wx=35
            p_wy=19
            p_wm=3
        end
    elseif p_map==3 then
        p_wx=32
        p_wy=15
        p_wm=2
    elseif p_map==6 then
        if p_x>336 then
            p_wx=1
            p_wy=15
            p_wm=2
        else
            p_wx=64
            p_wy=60
            p_wm=7
        end
    elseif p_map==7 then
        p_wx=35
        p_wy=46
        p_wm=6
    elseif p_map==9 then
        p_wx=42
        p_wy=14
        p_wm=1
        if p_x<200 then
            p_submap=4
        else
            p_submap=5
        end
    elseif p_map==10 then
        p_wx=64
        p_wy=11
        p_wm=11
    elseif p_map==11 then
        p_wx=1
        p_wy=53
        p_wm=10
    end
end

function set_bg()
    bg=map_bg[p_map]
    if bg==11 and not event_flags[9] then
        bg=1
    end
end

function draw_sprites()
    set_colors(0)
    if p_map==0 then
        cls()
        print_combat_string(c_str)
        print("hp: "..p_hp,56,112,7)
    elseif p_map==1 then
        draw_map1_interior()
    elseif p_map==2 then
        if not event_flags[9] then
            set_colors(1)
        else
            if not event_flags[5] then
                spr(114,216,112)
            end
            spr(116,32,152)
            spr(40,240,32)
        end
        if not event_flags[3] then
            spr(113,16,128)
        end
    elseif p_map==3 then
        set_colors(3)
        spr(112,344,144)
        if not event_flags[5] and p_y>192 and (p_x<344 or p_y<312) then
            map_fog(0)
        end
        if event_flags[4] and not event_flags[5] then
            spr(poi_sp,352,320)
        end
    elseif p_map==4 then
        cls()
        circfill(464,36,48,6)
        if p_state==7 then
            draw_game_over()
        elseif p_state==8 then
            draw_main_menu()
        end
    elseif p_map==5 then
        if not event_flags[4] then
            set_colors(1)
            map_fog(0)
        else
            map_fog(5)
        end
    elseif p_map==6 then
        set_colors(7)
    elseif p_map==7 then
        if not event_flags[4] then
            set_colors(1)
        end
        if not event_flags[3] then
            spr(poi_sp,464,432)
        end
    elseif p_map==8 then
        set_colors(5)
        if p_y>232 then
            map_fog(5)
        end
    elseif p_map==9 then
        if event_flags[11] or not event_flags[5] then
            spr(115,216,456)
        end
    elseif p_map==10 then
        map_fog(5)
    elseif p_map==11 and not event_flags[11] then
        spr(87,464,56)
        spr(72,448,64)
        spr(71,480,64)
        spr(72,456,88)
        spr(71,472,88)
    end
    if event_flags[7] then
        pal(15,8)
    end
    if event_flags[6] and p_map==8 then
        spr(p_sp+10,p_x,p_y,1,1,p_flp)
    else
        spr(p_sp,p_x,p_y,1,1,p_flp)
    end
end

function draw_map1_interior()
    if p_submap==1 then
        spr(42,384,8,1,2)
        spr(42,280,80,1,2)
        spr(115,360,32)
        if not event_flags[3] then
            spr(73,288,96)
        else
            spr(73,360,96)
        end
    elseif p_submap==2 then
        spr(112,368,16)
    elseif p_submap==3 then
        spr(42,384,8,1,2)
        spr(112,336,88)
        if not event_flags[9] then
            spr(121,384,8)
        end
    elseif p_submap==4 then
        spr(42,384,8,1,2)
        spr(42,280,80,1,2)
        spr(112,360,96)
        if not event_flags[11] then
            spr(71,288,96)
        end
    elseif p_submap==5 then
        spr(42,384,8,1,2)
        spr(88,360,96)
    end
end

function do_overworld_hazard()
    if p_map==3 or p_map==5 or p_map==6 or p_map==10 then
        knockback(4)
        p_hp-=1
    elseif p_map==8 then
        p_hp-=4
    end
    if p_hp<=0 then
        p_state=9
    end
end

function map_fog(c)
    if p_state==3 then
        return
    end
    rectfill(cam_x,cam_y,p_x-12,cam_y+128,c)
    rectfill(p_x+p_w+12,cam_y,p_x+128,cam_y+128,c)
    rectfill(cam_x,cam_y,cam_x+128,p_y-12,c)
    rectfill(cam_x,p_y+p_h+12,cam_x+128,cam_y+128,c)
end

function draw_main_menu()
    spr(69,456,16+6,2,3)
    spr(p_a_over,464,29)
    print("terradestined",438,16,1)
    print("NEW GAME",452,48,1)
    print("CONTINUE",452,56,1)
end

function draw_game_over()
    spr(96,456,32,3,1)
    spr(p_a_over,472,32)
    print("game over!",446,16,1)
    print("CONTINUE",452,48,1)
    print("QUIT",452,56,1)
end