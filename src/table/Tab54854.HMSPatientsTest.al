table 54854 "HMS-Patients Test"
{

    fields
    {
        field(1; "Doctor Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(2; "Patient Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3; Date; Date)
        {
            NotBlank = true;
        }
        field(4; Time; Time)
        {
        }
        field(5; "Test Code"; Code[20])
        {
            TableRelation = Resource."No.";

            trigger OnValidate()
            begin
                GetTests.RESET;
                GetTests.SETRANGE(GetTests."No.", "Test Code");

                IF GetTests.FIND('-') THEN BEGIN
                    Rec.Description := GetTests.Name;
                    // Rec.Minimum:=GetTests.Minimum;
                    //  Rec.Maximum:=GetTests.Maximum;
                    //Rec.MODIFY

                END;

                /*
                
                 SalesHeader."Document Type":=SalesHeader."Document Type"::Invoice;
                 SalesHeader."No.":='8';
                 SalesHeader."Sell-to Customer No.":="No.";
                 SalesHeader.VALIDATE("Sell-to Customer No.");
                 SalesHeader.INSERT;
                
                LineNo := 1;
                PatientsTest.RESET;
                PatientsTest.SETRANGE(PatientsTest."Patient Code","No.");
                PatientsTest.SETRANGE(PatientsTest.Posted,FALSE);
                IF PatientsTest.FIND('-') THEN BEGIN
                 REPEAT
                 SalesLine."Document Type":=SalesLine."Document Type"::Invoice;
                SalesLine."Line No.":=LineNo;
                SalesLine."Document No.":='8';
                SalesLine.Type:=SalesLine.Type::Resource;
                SalesLine."No.":=PatientsTest."Test Code";
                SalesLine.VALIDATE("No.");
                SalesLine.Quantity:=1;
                SalesLine."Unit Price":=PatientsTest.Charge;
                SalesLine.VALIDATE("Unit Price");
                SalesLine.INSERT;
                 LineNo := LineNo + 1;
                PatientsTest.Posted:=TRUE;
                PatientsTest.MODIFY;
                 UNTIL PatientsTest.NEXT=0;
                END;
                
                */

            end;
        }
        field(7; Remarks; Text[250])
        {
        }
        field(8; Posted; Boolean)
        {
            Editable = false;
        }
        field(9; Description; Text[200])
        {
        }
        field(10; Minimum; Decimal)
        {
        }
        field(11; Maximum; Decimal)
        {
        }
        field(12; "Actual Value"; Decimal)
        {
        }
        field(13; Expected; Boolean)
        {
        }
        field(14; Type; Text[50])
        {
        }
        field(15; Charge; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Date, "Patient Code", "Test Code")
        {
            Clustered = true;
        }
        key(Key2; Posted)
        {
        }
    }

    fieldgroups
    {
    }

    var
        GetTests: Record 156;
    //PatientsTests: Record "61473";
}

