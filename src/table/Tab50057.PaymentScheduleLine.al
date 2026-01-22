table 50057 "Payment Schedule Line"
{

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Payment No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Document Type" = CONST(Payment)) "FIN-Payments Header"."No." WHERE(Posted = FILTER(true),
                                                                                           "Payment Schedule No" = FILTER(' '),
                                                                                           "Payment Type" = FILTER('Normal|Petty Cash'))
            ELSE
            IF ("Document Type" = CONST(Imprest)) "FIN-Imprest Header"."No." WHERE(Posted = CONST(true))
            ELSE
            IF ("Document Type" = CONST(Interbank)) "FIN-InterBank Transfers".No WHERE(Posted = CONST(true));

            trigger OnValidate()
            begin
                IF pH.GET("Payment No") THEN BEGIN
                    pH.CALCFIELDS("Total Net Amount");
                    Payee := pH.Payee;
                    Amount := pH."Total Net Amount";
                    "Cheque Amount" := pH."Total Net Amount";
                    "Payment Narration" := pH."Payment Narration";
                END;
                IF ImpH.GET("Payment No") THEN BEGIN
                    ImpH.CALCFIELDS("Total Net Amount");
                    Payee := ImpH.Payee;
                    Amount := ImpH."Total Net Amount";
                    "Cheque Amount" := ImpH."Total Net Amount";
                    "Payment Narration" := ImpH.Purpose;
                END;

                IF InterBnk.GET("Payment No") THEN BEGIN
                    InterBnk.CALCFIELDS(Amount);
                    Payee := InterBnk.Remarks;
                    Amount := InterBnk.Amount;
                    "Cheque Amount" := InterBnk.Amount;
                    "Payment Narration" := InterBnk.Remarks;
                END;
            end;
        }
        field(3; Payee; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payment Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Payment,Imprest,Interbank';
            OptionMembers = Payment,Imprest,Interbank;
        }
        field(7; "Cheque Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "Payment No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        pH: Record "FIN-Payments Header";
        ImpH: Record "FIN-Imprest Header";
        InterBnk: Record "FIN-InterBank Transfers";
}

