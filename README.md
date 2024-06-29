# Parking Management System

## Tools

+ ModelSim
+ Verilog

## Logic

### Available Spots

```verilog
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
```

### Car Entry

```verilog
if (car_entered && (parked_car < TOTAL_SPOTS)) begin
    if (is_uni_car_entered && (uni_parked_car < UNI_SPOTS)) begin
        uni_parked_car <= uni_parked_car + 1;
        parked_car <= parked_car + 1;
    end else if (!is_uni_car_entered && (parked_car - uni_parked_car < general_available_spots)) begin
        parked_car <= parked_car + 1;
    end
end
```

### Car Exit

```verilog
if (car_exited && (parked_car > 0)) begin
    parked_car <= parked_car - 1;
    if (is_uni_car_exited && (uni_parked_car > 0)) begin
        uni_parked_car <= uni_parked_car - 1;
    end
end
```

### Vacated Space

```verilog
vacated_space <= general_available_spots - (parked_car - uni_parked_car);
uni_vacated_space <= UNI_SPOTS - uni_parked_car;
if(vacated_space > 0) begin
    is_vacated_space <= 1;
end
if(uni_vacated_space > 0) begin
    uni_is_vacated_space <= 1;
end
```

## TestBench

```verilog
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    current_hour = 0;
    car_entered = 0;
    is_uni_car_entered = 0;
    car_exited = 0;
    is_uni_car_exited = 0;

    #10;
    reset = 0;

    #10; current_hour = 8; car_entered = 1; is_uni_car_entered = 1;
    #10; car_entered = 0;
    #10; current_hour = 9; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;
    #10; current_hour = 10; car_exited = 1; is_uni_car_exited = 1;
    #10; car_exited = 0;
    #10; current_hour = 11; car_exited = 1; is_uni_car_exited = 0;
    #10; car_exited = 0;
    #10; current_hour = 13; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;
    #10; current_hour = 14; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;
    #10; current_hour = 15; car_entered = 1; is_uni_car_entered = 1;
    #10; car_entered = 0;
    #10; current_hour = 16; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;

    #100;
    $finish;
end

initial begin
    $monitor("Time: %0t | current_hour: %0d | uni_parked_car: %0d | parked_car: %0d | uni_vacated_space: %0d | vacated_space: %0d | uni_is_vacated_space: %b | is_vacated_space: %b", 
             $time, current_hour, uni_parked_car, parked_car, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space);
end
```

## Authors
+ Alireza Kaviani (401110512)
