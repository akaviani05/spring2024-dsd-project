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

## Authors
+ Alireza Kaviani (401110512)
