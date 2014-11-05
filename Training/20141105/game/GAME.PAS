type
	tboard=array[1..4,1..4] of byte;
var
	st,en,t1,t2:tboard;
	dfs:array[1..13000] of word;
	par:array[1..13000] of word;

	i,j:integer;
	f,r:integer;
	sw:byte; gen,obj:word;

procedure readboard(var b:tboard);
var i,j:integer; buf:string;
begin
	for i:=1 to 4 do begin
		readln(buf);
		repeat
			j:=pos(' ',buf);
			if j>0 then delete(buf,j,1);
		until j=0;
		b[i,1]:=ord(buf[1])-48;
		b[i,2]:=ord(buf[2])-48;
		b[i,3]:=ord(buf[3])-48;
		b[i,4]:=ord(buf[4])-48;
	end;
end;

function calc(var b:tboard):word;
var i,j:integer; res:word;
begin
	res:=0;
	for i:=1 to 4 do
		for j:=1 to 4 do
			res:=res*2+b[i,j];
	calc:=res;
end;

procedure decode(w:word; var b:tboard);
var i,j:integer;
begin
	for i:=4 downto 1 do
		for j:=4 downto 1 do begin
			b[i,j]:=w mod 2;
			w:=w div 2;
		end;
end;

procedure work;
type
	texist=array[0..65534] of boolean;
	pexist=^texist;

	procedure print;
	label out;
	var next,cur,prev,prev2:integer; total:integer; i,j:integer;
		d1,d2,d3:tboard; resu:word;
	begin
		cur:=r; prev:=par[cur]; prev2:=par[prev];
		decode(dfs[r],d3);
		par[r]:=0; total:=0;
		repeat
			prev2:=par[prev];
			par[prev]:=cur;
			cur:=prev;
			if prev2=0 then break;
			prev:=prev2;
			total:=total+1;
		until false;
		writeln(total+1);
		cur:=1;
		repeat
			next:=par[cur];
			if next=0 then break;
			decode(dfs[cur],d1); decode(dfs[next],d2);
			for i:=1 to 4 do
				for j:=1 to 4 do begin
					d3:=d1;
					if j<4 then begin
						sw:=d3[i,j]; d3[i,j]:=d3[i,j+1]; d3[i,j+1]:=sw;
						resu:=calc(d3);
						if resu=calc(d2) then begin
							write(i,j,i,j+1);
							goto out;
						end;
					end;
					d3:=d1;
					if i<4 then begin
						sw:=d3[i,j]; d3[i,j]:=d3[i+1,j]; d3[i+1,j]:=sw;
						resu:=calc(d3);
						if resu=calc(d2) then begin
							write(i,j,i+1,j);
							goto out;
						end;
					end;
				end;
out:
			writeln;
			cur:=next;
		until false;
	end;
var exist:pexist; cst:word;
begin
	new(exist);
	fillchar(exist^,sizeof(texist),0);
	cst:=calc(st);
		f:=1; r:=1; obj:=calc(en); exist^[cst]:=true; par[f]:=0;
		dfs[f]:=calc(st);
		repeat
			decode(dfs[f],t2);
			for i:=1 to 4 do begin
				for j:=1 to 4 do begin
					t1:=t2;
					if j<4 then begin
					sw:=t1[i,j]; t1[i,j]:=t1[i,j+1]; t1[i,j+1]:=sw;
					gen:=calc(t1);
					if gen=obj then begin
						r:=r+1;
						dfs[r]:=gen;
						exist^[gen]:=true;
						par[r]:=f;

						print;
						exit;
					end
					else if not exist^[gen] then begin
						r:=r+1;
						dfs[r]:=gen;
						exist^[gen]:=true;
						par[r]:=f;
					end;
				end;
				if i<4 then begin
					t1:=t2;
					sw:=t1[i,j]; t1[i,j]:=t1[i+1,j]; t1[i+1,j]:=sw;
					gen:=calc(t1);
					if gen=obj then begin
						r:=r+1;
						dfs[r]:=gen;
						exist^[gen]:=true;
						par[r]:=f;

						print;
						exit;
					end
					else if not exist^[gen] then begin
						r:=r+1;
						dfs[r]:=gen;
						exist^[gen]:=true;
						par[r]:=f;
					end;
				end;
				end;
			end;
			f:=f+1;
		until f>r;

end;

begin
	assign(input,'game.in'); reset(input);
	readboard(st);
	readboard(en);
	close(input);

	assign(output,'game.out'); rewrite(output);
	if calc(st)=calc(en) then
		writeln(0)
	else begin
		work;
	end;
	close(output);
end.
