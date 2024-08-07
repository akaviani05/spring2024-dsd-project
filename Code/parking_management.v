module parking_management (
    input wire clk,
    input wire reset,
    input wire [7:0] current_hour,
    input wire car_entered,
    input wire is_uni_car_entered,
    input wire car_exited,
    input wire is_uni_car_exited,
    output reg [9:0] uni_parked_car,
    output reg [9:0] parked_car,
    output reg [9:0] uni_vacated_space,
    output reg [9:0] vacated_space,
    output reg uni_is_vacated_space,
    output reg is_vacated_space
);

parameter TOTAL_SPOTS = 700;
parameter UNI_SPOTS = 500;
reg [9:0] general_available_spots;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        uni_parked_car <= 0;
        parked_car <= 0;
        uni_vacated_space <= 0;
        vacated_space <= 0;
        uni_is_vacated_space <= 0;
        is_vacated_space <= 0;
    end else begin
        if (current_hour >= 8 && current_hour < 13) begin
            general_available_spots <= 200;
        end else if (current_hour >= 13 && current_hour < 14) begin
            general_available_spots <= 250;
        end else if (current_hour >= 14 && current_hour < 15) begin
            general_available_spots <= 300;
        end else if (current_hour >= 15 && current_hour < 16) begin
            general_available_spots <= 350;
        end else begin
            general_available_spots <= 500 - (parked_car - uni_parked_car);
        end

        if (car_entered && (parked_car < TOTAL_SPOTS)) begin
            if (is_uni_car_entered && (uni_parked_car < UNI_SPOTS)) begin
                uni_parked_car <= uni_parked_car + 1;
                parked_car <= parked_car + 1;
            end else if (!is_uni_car_entered && (parked_car - uni_parked_car < general_available_spots)) begin
                parked_car <= parked_car + 1;
            end
        end

        if (car_exited && (parked_car > 0)) begin
            parked_car <= parked_car - 1;
            if (is_uni_car_exited && (uni_parked_car > 0)) begin
                uni_parked_car <= uni_parked_car - 1;
            end
        end

		vacated_space <= general_available_spots - (parked_car - uni_parked_car);
		uni_vacated_space <= UNI_SPOTS - uni_parked_car;
		if(vacated_space > 0) begin
			is_vacated_space <= 1;
		end
		if(uni_vacated_space > 0) begin
			uni_is_vacated_space <= 1;
		end
    end
end

endmodule

