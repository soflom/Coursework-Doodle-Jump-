uses GraphABC;
type point = record
        x, y: integer;
    end;
type pointb = record
        xb, yb: integer;
    end;
type pointc = record
        xc, yc: integer;
    end;
type pointd = record
        xd, yd: integer;
    end;
type pointe = record
        xe, ye: integer;
    end;
type pointf = record
        xf, yf: integer;
    end;
var
    doodler, background, platform, blueplatform, fon1, fon2, wood1, wood2, one, attack, monster, pruj, hole: picture;
    Left, Right, space, x, y, xb, yb, xc, yc, xd, yd, xf, yf, a, b, i, j, k, l, m, n, p, h, mns, pr, score, hl, mh, nh, mnst, sc, err, plat, platblue, woo, onn, pb1, pb2, pb3, pb4, pb5, pb6, pb7, vminus: integer;
    vx, vy, vplus: real;
    platforms: array [1..20] of point;
    blueplatforms: array [1..7] of pointb;
    woods1: array [1..5] of pointc;
    woods2: array [1..5] of pointe;
    ones: array [1..3] of pointd;
    prujs: array [1..4] of pointf;
    game, active, settings, gameover, name, dood, thanks: boolean;
    t : text;
    Data: array[1..5] of string;

procedure KeyDown(Key: integer);
begin
    if Key = vk_Left then Left := 1;
    if Key = vk_Right then Right := 1;
    if key = vk_Escape then game := false;
    if key = vk_Escape then settings := false;
    if key = vk_Escape then gameover := false;
    if Key = vk_Space then space := 1;
end;

procedure KeyUp(Key: integer);
begin
    if Key = vk_Left then Left := 0;
    if Key = vk_Right then Right := 0;
    if Key = vk_Space then space := 0;
end;

procedure MouseUp(x, y, mb: integer);
begin
    if (mb = 1) and (x > 340) and (x < 500) and (y > 30) and (y < 80) then game := true;
    if (mb = 1) and (x > 340) and (x < 500) and (y > 90) and (y < 140) then settings := true;
    if (mb = 1) and (x > 340) and (x < 500) and (y > 150) and (y < 200) then active := false;
    if (mb = 1) and (x > 100) and (x < 300) and (y > 133) and (y < 163) and (gameover = true) then begin game := true; gameover := false; end;
end;

procedure MouseUpSettings(x, y, mb: integer);
begin
    if (mb = 1) and (x > 149) and (x < 240) and (y > 50) and (y < 68) then name := true;
    if (mb = 1) and (x > 250) and (x < 357) and (y > 50) and (y < 107) then dood := true;
end;

begin
    window.Caption := 'Doodle_Jump';
    SetWindowSize(532, 850);
    window.IsFixedSize := true;
    LockDrawing;
    OnKeyDown := KeyDown;
    OnKeyUp := KeyUp;
    OnMouseUp := MouseUp;
    background := picture.Create('C:\\dudl\background.png');
    platform := picture.Create('C:\\dudl\platform.png');
    blueplatform := picture.Create('C:\\dudl\blueplatform.png');
    wood1 := picture.Create('C:\\dudl\wood1.png');
    one := picture.Create('C:\\dudl\one.png');
    attack := picture.Create('C:\\dudl\attack.png');
    pruj := picture.Create('C:\\dudl\pruj.png');
    
    active := true;
    game := false;
    gameover := false;
    
    while active do
    begin
        assign(t, 'C:\\dudl\database');
        reset(t);
        for i := 1 to 5 do readln(t,Data[i]);
        close(t);
        var doodpic1 := 'C:\\dudl\doodler';
        var doodpic2 := Data[5];
        var doodpic3 := '.png';
        var doodpic := 'C:\\dudl\doodler1.png';
        doodpic := doodpic1 + doodpic2 + doodpic3;
        doodler := picture.Create(doodpic);
        name := false;
        dood := false;
        OnMouseUp := MouseUp;
        
        ClearWindow;
        x := 266;
        y := 400;
        h := 425;
        for i := 1 to 20 do
        begin
            platforms[i].x := random(532);
            platforms[i].y := random(850);
        end;
        for j := 1 to 7 do
        begin
            blueplatforms[j].xb := random(532);
            blueplatforms[j].yb := random(850);
        end;
        for k := 1 to 5 do
        begin
            woods1[k].xc := random(532);
            woods1[k].yc := random(850);
        end;
        for l := 1 to 3 do
        begin
            ones[l].xd := random(532);
            ones[l].yd := random(850);
        end;
        for p := 1 to 4 do
        begin
            prujs[p].xf := random(532);
            prujs[p].yf := random(850);
        end;
        
        mh := random(520);
        nh := 0;
        m := random(520);
        n := 0;
        
        plat := 20; //кол-во платформ
        platblue := 3;
        woo := 5;
        onn := 3;
        mns := 1;
        pr := 4;
        hl := 1;
        
        SetPenColor(clBlack);
        SetFontColor(clBlack);
        SetBrushColor(clTransparent);
        setfontsize(10);
        SetPenColor(clBlack);
        SetBrushColor(clWhite);
        setfontsize(20);
        
        fon1:=picture.create('C:\\dudl\monstr.png');
        fon1.Draw(5,340);
        fon2:=picture.create('C:\\dudl\nlo.png');
        fon2.Draw(10,20);
        
        Rectangle(340, 30, 500, 80);
        TextOut(360, 37, 'Начать');
        
        Rectangle(340, 90, 500, 140);
        TextOut(360, 97, 'Настройки');

        Rectangle(340, 150, 500, 200);
        TextOut(360, 157, 'Выход');
        
        SetFontColor(clBlack);
        setfontsize(30);
        TextOut(360, 420, 'Рекорд:');
        SetFontColor(clBlack);
        TextOut(360, 465, Data[1]);
        setfontsize(10);
        SetBrushColor(clTransparent);
        Redraw;
        
//--------------------------- ЦИКЛ НАСТРОЕК 
               
        while settings do
        begin
            ClearWindow;
            OnMouseUp := MouseUpSettings;
            SetPenColor(clBlack);
            SetFontColor(clBlack);
            SetBrushColor(clTransparent);
            SetBrushColor(clTransparent);
            SetFontColor(clYellow);
            SetBrushColor(clYellow);
            Rectangle(149, 50, 240, 68);
            SetBrushColor(clTransparent);
            SetFontColor(clBlack);
            TextOut(10, 50, 'Имя: ');
            SetFontColor(clBlack);
            TextOut(150, 50, Data[2]);
            SetFontColor(clBlack);
            TextOut(10, 70, 'Номер дудлера: ');
            SetFontColor(clBlack);
            TextOut(150, 70, Data[5]);
            picture.create(doodpic);
            doodler.draw(250, 50);
            SetFontColor(clBlack);
            TextOut(10, 90, 'Размер окна: ');
            SetFontColor(clBlack);
            TextOut(150, 90, '532x850');
            SetFontColor(clBlack);
            TextOut(10, 110, 'Вы находитесь в игре: ');
            SetFontColor(clBlack);
            TextOut(150, 110, (Milliseconds / 1000));
            TextOut(5,200, 'Суть игры заключается в том, чтобы добраться как можно выше');
            TextOut(5,220, 'Для управления дудлом используйте кнопки вправо и влево');
            TextOut(5,240, 'на клавиатуре');
            TextOut(5,260, 'Для выхода в предыдущее окно нажмите кнпку esc');
            TextOut(5,280, 'Для атаки дудлом нажмите пробел');
            TextOut(5,300, 'Чтобы сменить ник, нажмите на желтое окошко, введите имя');
            TextOut(5,320, 'и нажмите кнопку ввести (либо кнопку enter');
            TextOut(5,340, 'Чтобы сменить дудла, нажмите на дудла и выберите цифру от 1 до 3');
            TextOut(5,360, 'Приятной игры :)');
            Redraw;
            if name then
            begin
            readln(Data[2]);
            name := false;
            end;
            if dood then
            begin
            readln(Data[5]);
            dood := false;
            end;
        end;
        score := 0;
        vplus := 0.1;
        vminus := -7;
        pb1 := -1; pb2 := -1; pb3 := -1; pb4 := -1; pb5 := -1; pb6 := -1; pb7 := -1;
        
//--------------------------- ПРОЦЕСС ИГРЫ
        while game do
        begin
            background.Draw(0, 0);
            for i := 1 to plat do 
            platform.Draw(platforms[i].x, platforms[i].y);
            for j := 1 to platblue do 
            blueplatform.Draw(blueplatforms[j].xb, blueplatforms[j].yb);
            for k := 1 to woo do 
            wood1.Draw(woods1[k].xc, woods1[k].yc);
            for p := 1 to pr do
            pruj.Draw(prujs[p].xf, prujs[p].yf);
            if score >= 4000 then
            for l := 1 to onn do 
            one.Draw(ones[l].xd, ones[l].yd);
            doodler.Draw(x, y);
            
            
if (blueplatforms[1].xb < 2) or (blueplatforms[1].xb > 476) then begin
pb1 := pb1*(-1);
end;
blueplatforms[1].xb := blueplatforms[1].xb + pb1;
blueplatform.Draw(blueplatforms[1].xb, blueplatforms[1].yb);

if (blueplatforms[2].xb < 2) or (blueplatforms[2].xb > 476) then begin
pb2 := pb2*(-1);
end;
blueplatforms[2].xb := blueplatforms[2].xb + pb2;
blueplatform.Draw(blueplatforms[2].xb, blueplatforms[2].yb);

if (blueplatforms[3].xb < 2) or (blueplatforms[3].xb > 476) then begin
pb3 := pb3*(-1);
end;
blueplatforms[3].xb := blueplatforms[3].xb + pb3;
blueplatform.Draw(blueplatforms[3].xb, blueplatforms[3].yb);

if score >= 2000 then begin
platblue := 4;
if (blueplatforms[4].xb < 2) or (blueplatforms[4].xb > 476) then begin
pb4 := pb4*(-1);
end;
blueplatforms[4].xb := blueplatforms[1].xb + pb4;
blueplatform.Draw(blueplatforms[4].xb, blueplatforms[4].yb);
end;

if score >= 3200 then begin
platblue := 5;
if (blueplatforms[5].xb < 2) or (blueplatforms[5].xb > 476) then begin
pb5 := pb5*(-1);
end;
blueplatforms[5].xb := blueplatforms[5].xb + pb5;
blueplatform.Draw(blueplatforms[5].xb, blueplatforms[5].yb);
end;

if score >= 4500 then begin
platblue := 6;
if (blueplatforms[6].xb < 2) or (blueplatforms[6].xb > 476) then begin
pb6 := pb6*(-1);
end;
blueplatforms[6].xb := blueplatforms[6].xb + pb6;
blueplatform.Draw(blueplatforms[6].xb, blueplatforms[6].yb);
end;

if score >= 5100 then begin
platblue := 7;
if (blueplatforms[7].xb < 2) or (blueplatforms[7].xb > 476) then begin
pb7 := pb7*(-1);
end;
blueplatforms[7].xb := blueplatforms[7].xb + pb7;
blueplatform.Draw(blueplatforms[7].xb, blueplatforms[7].yb);
end;

            TextOut(10, 10, score.ToString);
            val(Data[1], sc, err);
            SetBrushColor(clTransparent);
            SetPenColor(clBlack);
            if score > sc then TextOut(10, 30, 'Побит рекорд!');

            if Left = 1 then begin 
            x := x - 4;
            var doodpic10 := 'C:\\dudl\doodler';
            var doodpic20 := Data[5] + 10;
            var doodpic30 := '.png';
            var doodpic0 := 'C:\\dudl\doodler1.png';
            doodpic := doodpic10 + doodpic20 + doodpic30;
            doodler := picture.Create(doodpic);
            end;
            if Right = 1 then begin
            x := x + 4;
            var doodpic10 := 'C:\\dudl\doodler';
            var doodpic20 := Data[5];
            var doodpic30 := '.png';
            var doodpic0 := 'C:\\dudl\doodler1.png';
            doodpic := doodpic10 + doodpic20 + doodpic30;
            doodler := picture.Create(doodpic);
            end;
            if space = 1 then begin
            doodler := picture.Create('C:\\dudl\doodv.png');
            a := x+22; b := y;
            attack.Draw(a,b);
            end;
            if space = 0 then
            doodler := picture.Create(doodpic);
            b := b-8;
            attack.Draw(a,b);
            
            if (a > m) and
              		(a < m + 56) and
              		(b > n) and
              		(b < n + 56) and (vy > 0) then begin
              		n:=1000;
              		monster := picture.create('C:\\dudl\monster.png');
                  monster.Draw(m,n);
              		end;
            if (x + 36 > m) and
              		(x + 5 < m + 56) and
              		(y + 53 > n) and
              		(y + 53 < n + 56) and (vy > 0) then begin
              		vy := vminus;
              		n:=1000;
              		monster := picture.create('C:\\dudl\monster.png');
                  monster.Draw(m,n);
              		end;
              		
            if (x + 36 > m) and
              		(x + 5 < m + 56) and
              		(y > n) and
              		(y < n + 56) then begin
              		game := false;
                  gameover := true;
                  break
                  end;
             if (x + 36 > mh) and
              		(x + 5 < mh + 56) and
              		(y > nh) and
              		(y < nh + 56) then begin
              		game := false;
                  gameover := true;
                  break
                  end;  

            vy := vy + vplus;
            y := y + round(vy);
            
            if score > 2000 then begin
            hole := picture.create('C:\\dudl\bhole.png');
            hole.Draw(mh,nh);
            if y < h then
            nh := nh - round(vy);
            if round(vy) > 0 then
            nh := nh;
            end;
            if score > 1000 then begin
            monster := picture.create('C:\\dudl\monster.png');
            monster.Draw(m,n);
            if y < h then
            n := n - round(vy);
            if round(vy) > 0 then
            n := n;
            end;
            
            for p := 1 to pr do
                if (x + 36 > prujs[p].xf) and
              		(x + 5 < prujs[p].xf + 56) and
              		(y + 53 > prujs[p].yf) and
              		(y + 53 < prujs[p].yf + 14) and (vy > 0) then
                    vy := vminus - 3;
            for i := 1 to plat do
                if (x + 36 > platforms[i].x) and
              		(x + 5 < platforms[i].x + 56) and
              		(y + 53 > platforms[i].y) and
              		(y + 53 < platforms[i].y + 14) and (vy > 0) then
                    vy := vminus;
            for j := 1 to platblue do
                if (x + 36 > blueplatforms[j].xb) and
              		(x + 5 < blueplatforms[j].xb + 56) and
              		(y + 53 > blueplatforms[j].yb) and
              		(y + 53 < blueplatforms[j].yb + 14) and (vy > 0) then
                    vy := vminus;
            for k := 1 to woo do
                if (x + 36 > woods1[k].xc) and
              		(x + 5 < woods1[k].xc + 56) and
              		(y + 53 > woods1[k].yc) and
              		(y + 53 < woods1[k].yc + 14) and (vy > 0) then begin
              		
              		wood2 := picture.create('C:\\dudl\wood2.png');
              		woods2[1].xe := woods1[k].xc;
              		woods2[1].ye := woods1[k].yc;
                  wood2.Draw(woods2[1].xe,woods2[1].ye);
                  woods1[k].yc := woods1[k].yc + 1000;
                  wood1.Draw(woods1[k].xc,woods1[k].yc);
                 end;
                 woods2[1].ye := woods2[1].ye + 5;
                 wood2:=picture.create('C:\\dudl\wood2.png');
                 wood2.Draw(woods2[1].xe,woods2[1].ye);
            for l := 1 to onn do
                if (x + 36 > ones[l].xd) and
              		(x + 5 < ones[l].xd + 56) and
              		(y + 53 > ones[l].yd) and
              		(y + 53 < ones[l].yd + 14) and (vy > 0) then begin
              		vy := vminus;
              		while ones[l].yd <> 850 do
                 ones[l].yd := ones[l].yd + 1;
                 one.Draw(ones[l].xd, ones[l].yd);
                 end;
            if y < h then
            begin
                for p := 1 to pr do
                begin
                    y := h;
                    prujs[p].yf := prujs[p].yf - round(vy);
                    if prujs[p].yf > 850 then
                    begin
                        prujs[p].yf := 0;
                        prujs[p].xf := random(532);
                    end;
                end;
                for i := 1 to plat do
                begin
                    y := h;
                    platforms[i].y := platforms[i].y - round(vy);
                    if platforms[i].y > 850 then
                    begin
                        platforms[i].y := 0;
                        platforms[i].x := random(532);
                    end;
                end;
                for j := 1 to platblue do
                begin
                    yb := h;
                    blueplatforms[j].yb := blueplatforms[j].yb - round(vy);
                    if blueplatforms[j].yb > 850 then
                    begin
                        blueplatforms[j].yb := 0;
                        blueplatforms[j].xb := random(532);
                    end;
                end;
                for k := 1 to woo do
                begin
                    yc := h;
                    woods1[k].yc := woods1[k].yc - round(vy);
                    if woods1[k].yc > 850 then
                    begin
                        woods1[k].yc := 0;
                        woods1[k].xc := random(532);
                    end;
                end;
                for l := 1 to onn do
                begin
                    yd := h;
                    ones[l].yd := ones[l].yd - round(vy);
                    if ones[l].yd > 850 then
                    begin
                        ones[l].yd := 0;
                        ones[l].xd := random(532);
                    end;
                end;
                score := score + 1;
            end;
            if y > 850 then
            begin
                game := false;
                gameover := true;
                break
            end;
            if score >= 2000 then plat := 19;
            if score >= 2500 then plat := 18;
            if score >= 3000 then plat := 17;
            if score >= 3500 then plat := 16;
            if score >= 4000 then plat := 15;
            if score >= 4500 then plat := 14;
            if score >= 5000 then plat := 13;
            if score >= 10000 then
            begin
                vplus := 0.2;
                vminus := -10;
            end;
           Redraw;
        end;
        while gameover do
        begin
            ClearWindow;
            OnMouseUp := MouseUp;
            background.Draw(0, 0);
            SetBrushColor(clTransparent);
            TextOut(10, 25, 'Игра закончена');
            SetBrushColor(clYellowGreen);
            Rectangle(100, 133, 300, 163);
            TextOut(180, 140, 'Снова?');
            SetBrushColor(clYellow);
            Rectangle(100, 190, 300, 220);
            TextOut(150, 197, 'Твой счет: ');
            TextOut(240, 197, score.ToString);
            vy := 0;
            val(Data[1], sc, err);
            SetBrushColor(clTransparent);
            SetPenColor(clBlack);
            if score > sc then 
            TextOut(100, 230, 'Новый рекорд!');
            Redraw;
        end;
        if score > sc then 
        Data[1] := score.ToString;
        assign(t,'C:\\dudl\database');
        rewrite(t);
        for i := 1 to 5 do 
        writeln(t, Data[i]);close(t);
    end;
    Halt;
end.
