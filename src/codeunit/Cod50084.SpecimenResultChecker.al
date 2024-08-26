codeunit 50084 "Specimen Result Checker"
{
    procedure CheckSpecimenResult(var Specimen: Record "HMS-Setup Test Specimen")
    var
        MinValue: Decimal;
        MaxValue: Decimal;
        Result: Decimal;
    begin
        // Ensure the values are retrieved correctly
        MinValue := Specimen."Minimum Value";
        MaxValue := Specimen."Maximum Value";
        Result := EvaluateDecimal(Specimen.Result);

        // Compare the result with the minimum and maximum values
        if Result < MinValue then
            Specimen.Flag := 'Low'
        else if Result > MaxValue then
            Specimen.Flag := 'High'
        else
            Specimen.Flag := '  ';

        Specimen.Modify();
    end;

    procedure EvaluateDecimal(Value: Code[60]): Decimal
    var
        DecValue: Decimal;
    begin
        if not Evaluate(DecValue, Value) then
            Error('Invalid result value: %1', Value);

        exit(DecValue);
    end;
}

