table 51316 "Causes & Effects2"
{
    Caption = 'Causes & Effects';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {

            AutoIncrement = true;
        }
        field(2; "Risk No"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(3; "Risk Details Line"; Code[90])
        {
            Caption = 'Risk Details Line';
            TableRelation = "Risk Details";
        }
        field(4; Causes; Text[250])
        {
            Caption = 'Causes';
        }
        field(5; Effects; Text[250])
        {
            Caption = 'Effects';
        }
        field(6; "Risk Category"; Code[130])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Details";
        }
        field(7; "Opportunity (identify)"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Risk Likelihood Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin


            end;
        }
        field(9; "Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Evaluation Score".Description where(Type = filter(Likelihood));

            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                // Reset and filter the Risk Evaluation Score record for Likelihood type
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(Description, "Risk Likelihood");
                ObjRiskEve.SetRange(Type, ObjRiskEve.Type::Likelihood); // Ensure filtering for Likelihood type

                if ObjRiskEve.FindFirst() then begin
                    "Risk Likelihood Value" := ObjRiskEve.Score;
                    "Risk Rating" := ObjRiskEve."Risk Rating";
                end else
                    Error('Risk Likelihood "%1" not found in Risk Evaluation Score table.', "Risk Likelihood");

                // Calculate Risk (L * I) value
                "Risk (L * I)" := "Risk Impact Value Main" * "Risk Likelihood Value";
            end;
        }


        field(10; "Risk Impact Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(11; "Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Risk (L * I)" := ("Risk Impact Value Main" + "Risk Likelihood Value");
            end;
        }
        field(12; "Risk Rating"; Enum "Audit Risk Ratings")
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Risk Impact"; Code[60])
        {
            TableRelation = "Risk Evaluation Score".Description where(Type = filter(Impact));

            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                // Reset and filter the Risk Evaluation Score record for Impact type
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(Description, "Risk Impact");
                ObjRiskEve.SetRange(Type, ObjRiskEve.Type::Impact); // Ensure filtering for Impact type

                if ObjRiskEve.FindFirst() then begin
                    "Risk Impact Value" := ObjRiskEve.Score;
                end else
                    Error('Risk Impact "%1" not found in Risk Evaluation Score table.', "Risk Impact");
            end;
        }


        field(24; Q1; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Q2; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Q3; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Risk Likelihood Value Q2"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin


            end;
        }
        field(28; "Risk Likelihood Q2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Evaluation Score".Description where(Type = filter(Likelihood));

            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Likelihood Q2");
                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Likelihood Value Q2" := ObjRiskEve.Score;
                    "Risk Rating Q2" := ObjRiskEve."Risk Rating";
                end;
                "Risk (L * I) Q2" := "Risk Impact Value Main" * "Risk Likelihood Value Q2";
            end;
        }
        field(30; "Risk Impact Value Q2"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(31; "Risk (L * I) Q2"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Risk (L * I) Q2" := ("Risk Impact Value Main" + "Risk Likelihood Value Q2");
            end;
        }
        field(32; "Risk Rating Q2"; Enum "Audit Risk Ratings")
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Risk Impact Q2"; Code[60])
        {
            TableRelation = "Risk Evaluation Score".Description where(Type = filter(Impact));
            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Impact Q2");

                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Impact Value Q2" := ObjRiskEve.Score;
                    //  VALIDATE("Risk Impact Value");
                end;
            end;
        }
        field(34; "Risk Likelihood Value Q3"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin


            end;
        }
        field(35; "Risk Likelihood Q3"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Evaluation Score".Description where(Type = filter(Likelihood));

            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Likelihood Q3");
                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Likelihood Value Q3" := ObjRiskEve.Score;
                    "Risk Rating Q3" := ObjRiskEve."Risk Rating";
                end;
                "Risk (L * I) Q3" := "Risk Impact Value Main" * "Risk Likelihood Value Q3";
            end;
        }
        field(36; "Risk Impact Value Q3"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(37; "Risk (L * I) Q3"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Risk (L * I) Q3" := ("Risk Impact Value Main" + "Risk Likelihood Value Q3");
            end;
        }
        field(38; "Risk Rating Q3"; Enum "Audit Risk Ratings")
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Risk Impact Q3"; Code[60])
        {
            TableRelation = "Risk Evaluation Score".Description where(Type = filter(Impact));
            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Impact Q3");

                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Impact Value Q3" := ObjRiskEve.Score;
                    //  VALIDATE("Risk Impact Value");
                end;
            end;
        }
        field(40; "Risk Likelihood Value Main"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin


            end;
        }
        field(41; "Risk Likelihood Main"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Evaluation Score".Description where(Type = filter(Likelihood));

            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Likelihood Main");
                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Likelihood Value Main" := ObjRiskEve.Score;
                    "Risk Rating Main" := ObjRiskEve."Risk Rating";
                end;
                "Risk (L * I) Main" := "Risk Impact Value Main" * "Risk Likelihood Value Main";
            end;
        }
        field(42; "Risk Impact Value Main"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(43; "Risk (L * I) Main"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Risk (L * I) Main" := ("Risk Impact Value Main" + "Risk Likelihood Value Main");
            end;
        }
        field(44; "Risk Rating Main"; Enum "Audit Risk Ratings")
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Risk Impact Main"; Code[60])
        {
            TableRelation = "Risk Evaluation Score".Description where(type = filter(Impact));
            trigger OnValidate()
            var
                ObjRiskEve: Record "Risk Evaluation Score";
            begin
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Impact Main");

                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Impact Value Main" := ObjRiskEve.Score;
                    //  VALIDATE("Risk Impact Value");
                end;
            end;
        }
        field(46; "Document Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Champion,Risk Owner,Risk Manager,Closed,Register,Corporate';
            OptionMembers = New,Champion,"Risk Owner","Risk Manager",Closed,Register,Corporate;
        }
        field(47; "Line Risk Category"; Code[130])
        {
            //TableRelation = "Risk Details"."Risk Category" where("Risk Details Line" = field("Risk Details Line"));
        }

    }
    keys
    {
        key(PK; "Entry No", "Risk Details Line", "Risk Category")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        ObjRiskDetails.Reset();
        ObjRiskDetails.SetRange(ObjRiskDetails."Risk Details Line", "Risk Details Line");
        if ObjRiskDetails.FindFirst() then begin

            "Line Risk Category" := ObjRiskDetails."Risk Category";
            ObjRiskDetails.Modify();
        end;
    end;

    var
        ObjRiskDetails: Record "Risk Details";

}
