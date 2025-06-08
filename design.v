module lcd_display(
    input wire clk,
    input wire reset,
    output reg [7:0] data,
    output reg rs,
    output reg rw,
    output reg en
);
    reg [6:0] state;
    reg [7:0] alphanumeric [0:61];  
    reg [6:0] index;
    initial begin
        alphanumeric[0]  = 8'h41; // 'A'
        alphanumeric[1]  = 8'h42; // 'B'
        alphanumeric[2]  = 8'h43; // 'C'
        alphanumeric[3]  = 8'h44; // 'D'
        alphanumeric[4]  = 8'h45; // 'E'
        alphanumeric[5]  = 8'h46; // 'F'
        alphanumeric[6]  = 8'h47; // 'G'
        alphanumeric[7]  = 8'h48; // 'H'
        alphanumeric[8]  = 8'h49; // 'I'
        alphanumeric[9]  = 8'h4A; // 'J'
        alphanumeric[10] = 8'h4B; // 'K'
        alphanumeric[11] = 8'h4C; // 'L'
        alphanumeric[12] = 8'h4D; // 'M'
        alphanumeric[13] = 8'h4E; // 'N'
        alphanumeric[14] = 8'h4F; // 'O'
        alphanumeric[15] = 8'h50; // 'P'
        alphanumeric[16] = 8'h51; // 'Q'
        alphanumeric[17] = 8'h52; // 'R'
        alphanumeric[18] = 8'h53; // 'S'
        alphanumeric[19] = 8'h54; // 'T'
        alphanumeric[20] = 8'h55; // 'U'
        alphanumeric[21] = 8'h56; // 'V'
        alphanumeric[22] = 8'h57; // 'W'
        alphanumeric[23] = 8'h58; // 'X'
        alphanumeric[24] = 8'h59; // 'Y'
        alphanumeric[25] = 8'h5A; // 'Z'
        
        alphanumeric[26] = 8'h61; // 'a'
        alphanumeric[27] = 8'h62; // 'b'
        alphanumeric[28] = 8'h63; // 'c'
        alphanumeric[29] = 8'h64; // 'd'
        alphanumeric[30] = 8'h65; // 'e'
        alphanumeric[31] = 8'h66; // 'f'
        alphanumeric[32] = 8'h67; // 'g'
        alphanumeric[33] = 8'h68; // 'h'
        alphanumeric[34] = 8'h69; // 'i'
        alphanumeric[35] = 8'h6A; // 'j'
        alphanumeric[36] = 8'h6B; // 'k'
        alphanumeric[37] = 8'h6C; // 'l'
        alphanumeric[38] = 8'h6D; // 'm'
        alphanumeric[39] = 8'h6E; // 'n'
        alphanumeric[40] = 8'h6F; // 'o'
        alphanumeric[41] = 8'h70; // 'p'
        alphanumeric[42] = 8'h71; // 'q'
        alphanumeric[43] = 8'h72; // 'r'
        alphanumeric[44] = 8'h73; // 's'
        alphanumeric[45] = 8'h74; // 't'
        alphanumeric[46] = 8'h75; // 'u'
        alphanumeric[47] = 8'h76; // 'v'
        alphanumeric[48] = 8'h77; // 'w'
        alphanumeric[49] = 8'h78; // 'x'
        alphanumeric[50] = 8'h79; // 'y'
        alphanumeric[51] = 8'h7A; // 'z'

        alphanumeric[52] = 8'h30; // '0'
        alphanumeric[53] = 8'h31; // '1'
        alphanumeric[54] = 8'h32; // '2'
        alphanumeric[55] = 8'h33; // '3'
        alphanumeric[56] = 8'h34; // '4'
        alphanumeric[57] = 8'h35; // '5'
        alphanumeric[58] = 8'h36; // '6'
        alphanumeric[59] = 8'h37; // '7'
        alphanumeric[60] = 8'h38; // '8'
        alphanumeric[61] = 8'h39; // '9'
    end
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            index <= 0;
            rs <= 0;
            rw <= 0;
            en <= 0;
            data <= 8'b0; 
        end
        else begin
            case (state)
                0: begin
                    rs <= 0;
                    rw <= 0;
                    en <= 1;
                    data <= 8'h38; // Function Set
                    state <= 1;
                end
                1: begin
                    en <= 0;
                    state <= 2;
                end
                2: begin
                    rs <= 0;
                    rw <= 0;
                    en <= 1;
                    data <= 8'h0C; // Display ON
                    state <= 3;
                end
                3: begin
                    en <= 0;
                    state <= 4;
                end
                4: begin
                    rs <= 0;
                    rw <= 0;
                    en <= 1;
                    data <= 8'h01; // Clear Display
                    state <= 5;
                end
                5: begin
                    en <= 0;
                    state <= 6;
                end
                6: begin
                    rs <= 1;  // Select Data Register
                    rw <= 0;  // Write Operation
                    en <= 1;
                    data <= alphanumeric[index]; // Send alphanumeric data
                    index <= index + 1;
                    state <= 7;
                end
                7: begin
                    en <= 0;
                    if (index == 62) state <= 8;  // Finished sending characters
                    else state <= 6;  // Keep sending next character
                end
                8: begin
                    en <= 0;  // Idle state
                end
            endcase
        end
    end
endmodule
