table 51299 "Risk Details"
{
    Caption = 'Risk Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Risk Details Line"; Code[90])
        {
            Caption = 'Risk Details Line';
            DataClassification = ToBeClassified;
        }
        field(2; "Risk No."; Code[60])
        {
            Caption = 'Risk No.';
            DataClassification = ToBeClassified;
            TableRelation = "Risk Header";
        }
        field(3; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            Autoincrement = true;
        }
        field(4; "No.Series"; Code[10])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
        }
        field(5; "Root Cause Analysis"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(6; "Mitigation Suggestions"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(7; "Risk Description"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(8; "Existing Risk Controls"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(9; "Risk Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories" where(Type = const(Category));

            trigger OnValidate()
            begin

                IF RiskCategory.GET("Risk Category") THEN
                    "Risk Category Description" := RiskCategory.Description;
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

                IF RiskCategory.GET("Risk Type") THEN
                    "Risk Type Description" := RiskCategory.Description;
            end;
        }
        field(12; "Risk Type Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Risk Likelihood Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = average("Causes & Effects2"."Risk Likelihood Value Main" where("Risk Details Line" = field("Risk Details Line")));


        }
        field(14; "Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Evaluation Score".Description;

            trigger OnValidate()
            begin
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Likelihood");
                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Likelihood Value" := ObjRiskEve.Score;
                    "Risk Rating" := ObjRiskEve."Risk Rating";
                end;
            end;
        }
        field(15; "Risk Impact Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = average("Causes & Effects2"."Risk Impact Value Main" where("Risk Details Line" = field("Risk Details Line")));



        }
        field(16; "Risk (L * I)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = average("Causes & Effects2"."Risk (L * I) Main" where("Risk Details Line" = field("Risk Details Line")));
            trigger OnValidate()
            begin

            end;
        }
        field(17; "Residual Risk Likelihood"; Decimal)
        {
            Caption = 'Residual Risk Likelihood Value';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                RiskLikelihood.Reset();
                RiskLikelihood.SetRange("Likelihood Score", "Residual Risk Likelihood");
                IF RiskLikelihood.FindFirst() then begin
                    "Residual Risk Likelihood Cat" := RiskLikelihood.Code;
                end;
                "Residual Risk (L * I)" := ("Residual Likelihood Impact" * "Residual Risk Likelihood");

                IF "Residual Risk (L * I)" < 1 THEN
                    "Residual Risk (L * I)" := 1;
                Validate("Residual Risk (L * I)");
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
                RAGSetup.Reset();
                RAGSetup.SetFilter("Gross Risk start", '<=%1', "Residual Risk (L * I)");
                RAGSetup.SetFilter("Gross Risk end", '>=%1', "Residual Risk (L * I)");
                IF RAGSetup.FindFirst() then begin
                    //   "Residual RAG Status" := RAGSetup.Option;
                end;
            end;
        }
        field(20; "Residual Likelihood Impact"; Decimal)
        {
            Caption = 'Residual Risk Impact Value';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Residual Risk (L * I)" := ("Residual Likelihood Impact" * "Residual Risk Likelihood");

                IF "Residual Risk (L * I)" < 1 THEN
                    "Residual Risk (L * I)" := 1;
                Validate("Residual Risk (L * I)");
                IF RiskLikelihood.GET("Residual Likelihood Impact") THEN
                    "Residual Risk Impact" := RiskLikelihood.Code;
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
                ObjRiskEve.Reset();
                ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Impact");

                IF ObjRiskEve.Find('-') THEN begin
                    "Risk Impact Value" := ObjRiskEve.Score;
                    //  VALIDATE("Risk Impact Value");
                end;
            end;
        }
        field(24; Department; Code[90])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            FieldClass = FlowField;
            CalcFormula = lookup("Risk Header"."Risk Department" where("No." = field("Risk No.")));
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

            OptionCaption = 'New,Champion,Risk Owner,Risk Manager,Closed,Register,Corporate';
            OptionMembers = New,Champion,"Risk Owner","Risk Manager",Closed,Register,Corporate;
            // FieldClass = FlowField;
            // CalcFormula = lookup("Risk Details"."Document Status" where("Risk No." = field("Risk No.")));
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
            DataClassification = ToBeClassified;
            TableRelation = "Audit Header"."No.";
        }
        field(35; Causes; Text[250])
        {
            Caption = 'Causes';
        }
        field(36; Effects; Text[250])
        {
            Caption = 'Effects';
        }
        field(37; "No of Records"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Causes & Effects2" where("Risk Details Line" = field("Risk Details Line")));
        }
        field(38; "Objective"; Text[1000])
        {
            TableRelation = "Risk Objectives" where(Status = filter(Active));
        }
        field(39; Description; Text[250])
        {

        }
        field(40; "Shortcut Dimension 1 Code"; Code[50])
        {

        }
        field(41; "Risk Impact Value 2"; Decimal)
        {

        }
        field(42; "Risk (L * I) 2"; Decimal)
        {

        }
        field(43; "Risk Likelihood Value 2"; Decimal)
        {

        }
        field(44; "Funtion Code"; Code[90])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Function Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Objective Average"; Decimal)
        {

        }
        field(47; "Consolidated Records"; Boolean)
        {
            // Caption = 'MyField';
            DataClassification = ToBeClassified;
        }






    }
    keys
    {
        key(PK; "Risk Details Line", "Risk No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    Var
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RiskSetup: Record "Audit Setup";
    begin
        IF "Risk Details Line" = '' THEN BEGIN
            RiskSetup.GET();
            RiskSetup.TESTFIELD(RiskSetup."Risk Details Line");
            NoSeriesMgt.InitSeries(RiskSetup."Risk Details Line", xRec."No.Series", 0D, "Risk Details Line", "No.Series");
        end;

        if not "Consolidated Records" then begin
            ObjRiskHeader.Reset();
            ObjRiskHeader.SetRange(ObjRiskHeader."No.", "Risk No.");
            if ObjRiskHeader.FindFirst() then begin
                Objective := ObjRiskHeader."Risk Description2";
                ObjRiskHeader.Validate("Risk Description2");
                // Message('RiskCategory %1', Objective);
                // Description := ObjRiskHeader.Description;
                "Shortcut Dimension 1 Code" := ObjRiskHeader."Shortcut Dimension 1 Code";
                // "Funtion Code" := ObjRiskHeader."Funtion Code";
                // "Function Description" := ObjRiskHeader."Function Description";
            end;
        end;

    end;

    var
        ObjRiskHeader: Record "Risk Header";
        RiskCategory: Record "Risk Categories";
        RAGSetup: Record "Risk RAG Status";
        RiskImpact: Record "Risk Impacts";
        RiskLikelihood: Record "Risk Likelihood";
        ObjRiskEve: Record "Risk Evaluation Score";
}
