module tb_lcd_display;
    reg clk;
    reg reset;
    wire [7:0] data;
    wire rs;
    wire rw;
    wire en;
    lcd_display lcd (
        .clk(clk),
        .reset(reset),
        .data(data),
        .rs(rs),
        .rw(rw),
        .en(en)
    );
    always begin
        #5 clk = ~clk; 
    end
    initial begin
        $dumpfile("dumpfile.vcd");
    	$dumpvars(1);
        clk = 0;
        reset = 0;
        reset = 1;
        #10 reset = 0;
        #5; 
        lcd.index = 0; 
        lcd.alphanumeric[0] = 8'h48; // 'H'
        lcd.alphanumeric[1] = 8'h65; // 'e'
        lcd.alphanumeric[2] = 8'h6C; // 'l'
        lcd.alphanumeric[3] = 8'h6C; // 'l'
        lcd.alphanumeric[4] = 8'h6F; // 'o'
        lcd.alphanumeric[5] = 8'h20; // ' ' 
        lcd.alphanumeric[6] = 8'h57; // 'W'
        lcd.alphanumeric[7] = 8'h6F; // 'o'
        lcd.alphanumeric[8] = 8'h72; // 'r'
        lcd.alphanumeric[9] = 8'h6C; // 'l'
        lcd.alphanumeric[10] = 8'h64; // 'd'
        $display("Displaying 'Hello World' message:");
        for (int i = 0; i < 11; i = i + 1) begin
            $display("Character %0d: %c (hex: %h)", i, lcd.alphanumeric[i], lcd.alphanumeric[i]);
        end
        #270; 
        $finish; 
    end
endmodule
