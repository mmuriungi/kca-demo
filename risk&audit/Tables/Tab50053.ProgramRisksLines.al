table 51298 "Program Risks Lines"
{
    Caption = 'Program Risks Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Program Risk No"; Code[90])
        {
            Caption = 'Program Risk No';
            DataClassification = ToBeClassified;
        }
        field(2; "Program No"; Code[90])
        {
            Caption = 'Program No';
            DataClassification = ToBeClassified;
            TableRelation = "Audit Header";
        }
        field(3; "Risk No"; Code[90])
        {
            Caption = 'Risk No';
            DataClassification = ToBeClassified;
            TableRelation = "Audit Lines" where("Document No." = field("Audit Plan No."));
            trigger OnValidate()
            var
                ObjRiskDetails: Record "Audit Lines";
            begin
                ObjRiskDetails.Reset();
                ObjRiskDetails.SetRange(ObjRiskDetails."Document No.", "Risk No");
                if ObjRiskDetails.Find('-') then begin
                    "Risk Category" := ObjRiskDetails."Risk Category2";
                    "Risk Category Description" := ObjRiskDetails."Risk Category Description2";
                    "Risk Type" := ObjRiskDetails."Risk Type";
                    "Risk Type Description" := ObjRiskDetails."Risk Type Description";
                    "Risk Descriptions" := ObjRiskDetails."Risk Descriptions";
                    "Risk Likelihood" := ObjRiskDetails."Risk Likelihood";
                    "Risk Likelihood Value" := ObjRiskDetails."Risk Likelihood Value";
                    "Risk Rating" := ObjRiskDetails."Risk Rating";
                    "Risk Impact" := ObjRiskDetails."Risk Impact";
                    "Risk Impact Value" := ObjRiskDetails."Risk Impact Value";
                    "Risk (L * I)" := ObjRiskDetails."Risk (L * I)";
                    "Root Cause Analysis2" := ObjRiskDetails."Root Cause Analysis2";
                    "Mitigation Suggestions2" := ObjRiskDetails."Mitigation Suggestions2";
                end;
            end;
        }
        field(4; "Plan No"; Code[90])
        {
            Caption = 'Plan No';
            DataClassification = ToBeClassified;
        }
        field(5; "Risk Details Line"; Code[90])
        {
            Caption = 'Risk Details Line';
            DataClassification = ToBeClassified;
        }
        field(6; "No.Series"; Code[10])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
        }
        field(9; "Risk Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories" where(Type = const(Category));

            trigger OnValidate()
            begin

                //  IF RiskCategory.GET("Risk Category") THEN
                //  "Risk Category Description" := RiskCategory.Description;
            end;
        }
        field(10; "Risk Category Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Risk Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories" where(Type = const(Type));
            trigger OnValidate()
            begin

                //  IF RiskCategory.GET("Risk Type") THEN
                //  "Risk Type Description" := RiskCategory.Description;
            end;
        }
        field(12; "Risk Type Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Risk Likelihood Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            // InitValue = 0;


            trigger OnValidate()
            begin
                // "Risk (L * I)" := ("Risk Likelihood Value" * "Risk Impact Value");
                // "Residual Risk Likelihood" := ("Risk Likelihood Value" - "Control Evaluation Likelihood");

                // IF "Residual Risk Likelihood" < 1 THEN
                //     "Residual Risk Likelihood" := 1;
                // Validate("Risk (L * I)");

            end;
        }
        field(14; "Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Evaluation Score".Description;

            trigger OnValidate()
            begin
                // ObjRiskEve.Reset();
                // ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Likelihood");
                // IF ObjRiskEve.Find('-') THEN begin
                //     "Risk Likelihood Value" := ObjRiskEve.Score;
                //     "Risk Rating" := ObjRiskEve."Risk Rating";
                // end;
            end;
        }
        field(15; "Risk Impact Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Risk Evaluation Score".Description;
            trigger OnValidate()
            begin
                // "Risk (L * I)" := ("Risk Likelihood Value" * "Risk Impact Value");

                // IF "Risk (L * I)" < 1 THEN
                //     "Risk (L * I)" := 1;
                // Validate("Risk (L * I)");
            end;
        }
        field(16; "Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // RAGSetup.Reset();
                // RAGSetup.SetFilter("Gross Risk start", '<=%1', "Risk (L * I)");
                // RAGSetup.SetFilter("Gross Risk end", '>=%1', "Risk (L * I)");
                // IF RAGSetup.FindFirst() then begin
                //     //  "RAG Status" := RAGSetup.Option;
                // end;
                "Risk (L * I)" := ("Risk Impact Value" + "Risk Likelihood Value");
            end;
        }
        field(17; "Residual Risk Likelihood"; Decimal)
        {
            Caption = 'Residual Risk Likelihood Value';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // RiskLikelihood.Reset();
                // RiskLikelihood.SetRange("Likelihood Score", "Residual Risk Likelihood");
                // IF RiskLikelihood.FindFirst() then begin
                //     "Residual Risk Likelihood Cat" := RiskLikelihood.Code;
                // end;
                // "Residual Risk (L * I)" := ("Residual Likelihood Impact" * "Residual Risk Likelihood");

                // IF "Residual Risk (L * I)" < 1 THEN
                //     "Residual Risk (L * I)" := 1;
                // Validate("Residual Risk (L * I)");
            end;
        }
        field(18; "Residual Risk Likelihood Cat"; Code[20])
        {
            Caption = 'Residual Risk Likelihood';
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
            InitValue = '';

        }
        field(19; "Residual Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // RAGSetup.Reset();
                // RAGSetup.SetFilter("Gross Risk start", '<=%1', "Residual Risk (L * I)");
                // RAGSetup.SetFilter("Gross Risk end", '>=%1', "Residual Risk (L * I)");
                // IF RAGSetup.FindFirst() then begin
                //     //   "Residual RAG Status" := RAGSetup.Option;
                // end;
            end;
        }
        field(20; "Residual Likelihood Impact"; Decimal)
        {
            Caption = 'Residual Risk Impact Value';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // "Residual Risk (L * I)" := ("Residual Likelihood Impact" * "Residual Risk Likelihood");

                // IF "Residual Risk (L * I)" < 1 THEN
                //     "Residual Risk (L * I)" := 1;
                // Validate("Residual Risk (L * I)");
                // IF RiskLikelihood.GET("Residual Likelihood Impact") THEN
                //     "Residual Risk Impact" := RiskLikelihood.Code;
            end;
        }
        field(21; "Residual Risk Impact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            InitValue = '';

        }
        field(22; "Control Evaluation Likelihood"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  "Control Risk (L * I)" := ("Control Evaluation Impact" * "Control Evaluation Likelihood");
                "Residual Risk Likelihood" := ("Risk Likelihood Value" - "Control Evaluation Likelihood");

                IF "Residual Risk Likelihood" < 1 THEN
                    "Residual Risk Likelihood" := 1;

                VALIDATE("Residual Risk Likelihood");
            end;
        }
        field(23; "Risk Impact"; Code[60])
        {
            TableRelation = "Risk Evaluation Score".Description;

            trigger OnValidate()
            begin
                // ObjRiskEve.Reset();
                // ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Impact");

                // IF ObjRiskEve.Find('-') THEN begin
                //     "Risk Impact Value" := ObjRiskEve.Score;
                //     //  VALIDATE("Risk Impact Value");
                // end;
            end;
        }
        field(24; Department; Code[90])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //  FieldClass = FlowField;
            // CalcFormula = lookup("Risk Header"."Risk Department");
        }
        field(25; "To Consolidate"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(26; Consolidated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Document Status"; Option)
        {
            //DataClassification = ToBeClassified;
            OptionCaption = 'New,Champion,Officer,HOD,Champion 2,Closed,Project Manager,Register,Auditor';
            OptionMembers = New,Champion,Officer,HOD,"Champion 2",Closed,"Project Manager",Register,Auditor;
            // FieldClass = FlowField;
            //  CalcFormula = lookup("Risk Header"."Document Status" where("No." = field("Risk No.")));

        }
        field(28; "Root Cause Analysis2"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Mitigation Suggestions2"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Risk Descriptions"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(31; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Styling; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = none,Standard,StandardAccent,Strong,StrongAccent,Attention,AttentionAccent,Favorable,Unfavorable,Ambiguous,Surbodinate;
        }
        field(33; "Risk Rating"; Enum "Audit Risk Ratings")
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Audit Plan No."; Code[90])
        {
            // DataClassification = ToBeClassified;
            TableRelation = "Audit Header";
            FieldClass = FlowField;
            CalcFormula = lookup("Audit Header"."Audit Plan No." where("No." = field("Program No")));
        }




    }
    keys
    {
        key(PK; "Program Risk No", "Program No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Risk No")
        {

        }
    }
    trigger OnInsert()
    Var
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RiskSetup: Record "Audit Setup";
    begin
        IF "Program Risk No" = '' THEN BEGIN
            RiskSetup.GET();
            RiskSetup.TESTFIELD(RiskSetup."Program Risk No");
            NoSeriesMgt.InitSeries(RiskSetup."Program Risk No", xRec."No.Series", 0D, "Program Risk No", "No.Series");

        end;

    end;

    var
        RiskCategory: Record "Risk Categories";
        RAGSetup: Record "Risk RAG Status";
        RiskImpact: Record "Risk Impacts";
        RiskLikelihood: Record "Risk Likelihood";
        ObjRiskEve: Record "Risk Evaluation Score";
}


