table 51334 "Risk Header"
{


    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // begin
            //     IF "No." <> '' THEN
            //         NoSeriesMgt.TestManual(RiskSetup."Risk Nos.");
            // end;
        }
        field(2; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF Employee.GET("Employee No.") THEN BEGIN
                //     "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //     "Shortcut Dimension 1 Code" := Employee.Campus;
                //     "Shortcut Dimension 2 Code" := Employee."Department Code";
                // END;
            end;
        }
        field(5; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Risk Description"; Text[2048])
        {
            Caption = 'Risk Objectives';
            DataClassification = ToBeClassified;
        }
        field(7; "Document Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Champion,Risk Owner,Risk Manager,Closed,Register,Corporate';
            OptionMembers = New,Champion,"Risk Owner","Risk Manager",Closed,Register,Corporate;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Date Identified"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Risk Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories" where(Type = const(Category));

            trigger OnValidate()
            begin

                IF RiskCategory.GET("Risk Category") THEN
                    "Risk Category Description" := RiskCategory.Description;
            end;
        }
        field(11; "Risk Category Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Value at Risk"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            trigger OnValidate()
            begin
                RiskImpact.Reset();
                RiskImpact.SetFilter("Financial start", '<=%1', "Value at Risk");
                RiskImpact.SetFilter("Financial End", '>=%1', "Value at Risk");
                IF RiskImpact.FindFirst() then begin
                    "Risk Impact" := RiskImpact.Code;
                    "Risk Impact Value" := RiskImpact."Impact Score";
                    Validate("Risk Impact Value");
                    Validate("Risk Impact");
                    Validate("Risk (L * I)");
                    Validate("Residual Value");
                    "Residual Value" := "Value at Risk" - "Value after Control";
                    IF "Residual Value" < 1 THEN
                        "Residual Value" := 0;

                end;

            end;
        }
        field(13; "Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
            InitValue = '';

            trigger OnValidate()
            begin
                IF RiskLikelihood.GET("Risk Likelihood") THEN
                    "Risk Likelihood Value" := RiskLikelihood."Likelihood Score";
                VALIDATE("Risk Likelihood Value");
            end;
        }
        field(14; "Risk Impact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            InitValue = '';

            trigger OnValidate()
            begin
                IF RiskImpact.GET("Risk Impact") THEN
                    "Risk Impact Value" := RiskImpact."Impact Score";
                VALIDATE("Risk Impact Value");

                // "Residual Likelihood Impact" := ("Risk Impact Value" - "Control Evaluation Impact");

                // IF "Residual Likelihood Impact" < 1 THEN
                //     "Residual Likelihood Impact" := 1;
            end;
        }
        field(15; "Risk Likelihood Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;

            trigger OnValidate()
            begin
                "Risk (L * I)" := ("Risk Likelihood Value" * "Risk Impact Value");
                "Residual Risk Likelihood" := ("Risk Likelihood Value" - "Control Evaluation Likelihood");

                IF "Residual Risk Likelihood" < 1 THEN
                    "Residual Risk Likelihood" := 1;
                Validate("Risk (L * I)");

            end;
        }
        field(16; "Risk Impact Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Risk (L * I)" := ("Risk Likelihood Value" * "Risk Impact Value");

                IF "Risk (L * I)" < 1 THEN
                    "Risk (L * I)" := 1;
                Validate("Risk (L * I)");
            end;
        }
        field(17; "Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                RAGSetup.Reset();
                RAGSetup.SetFilter("Gross Risk start", '<=%1', "Risk (L * I)");
                RAGSetup.SetFilter("Gross Risk end", '>=%1', "Risk (L * I)");
                IF RAGSetup.FindFirst() then begin
                    "RAG Status" := RAGSetup.Option;
                end;
            end;
        }
        field(18; "Control Evaluation Likelihood"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Control Risk (L * I)" := ("Control Evaluation Impact" * "Control Evaluation Likelihood");
                "Residual Risk Likelihood" := ("Risk Likelihood Value" - "Control Evaluation Likelihood");

                IF "Residual Risk Likelihood" < 1 THEN
                    "Residual Risk Likelihood" := 1;

                VALIDATE("Residual Risk Likelihood");
            end;
        }
        field(19; "Control Evaluation Impact"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Control Risk (L * I)" := ("Control Evaluation Impact" * "Control Evaluation Likelihood");

                IF "Control Risk (L * I)" < 1 THEN
                    "Control Risk (L * I)" := 1;
                // "Residual Likelihood Impact" := ("Risk Impact Value" - "Control Evaluation Impact");

                // IF "Residual Likelihood Impact" < 1 THEN
                //     "Residual Likelihood Impact" := 1;

            end;
        }
        field(20; "Residual Risk Likelihood"; Decimal)
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
        field(21; "Residual Likelihood Impact"; Decimal)
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
        field(22; "Residual Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                RAGSetup.Reset();
                RAGSetup.SetFilter("Gross Risk start", '<=%1', "Residual Risk (L * I)");
                RAGSetup.SetFilter("Gross Risk end", '>=%1', "Residual Risk (L * I)");
                IF RAGSetup.FindFirst() then begin
                    "Residual RAG Status" := RAGSetup.Option;
                end;
            end;
        }
        field(23; "Risk Response"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Accept,Transfer,Mitigate,Avoid';
            OptionMembers = " ",Accept,Transfer,Mitigate,Avoid;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), "Dimension Value Type" = filter(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(26; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Released';
            OptionMembers = New,"Pending Approval",Released;
        }
        field(27; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Risk,Risk Opportunity';
            OptionMembers = " ",Risk,"Risk Opportunity";
        }
        field(28; "Risk Opportunity Assessment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Enhance,Exploit,Share,Do Nothing';
            OptionMembers = " ",Enhance,Exploit,Share,"Do Nothing";
        }
        field(29; "Risk Department"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;

            trigger OnValidate()
            begin
                // DimVal.RESET;
                // DimVal.SETRANGE("Global Dimension No.", 1);
                // DimVal.SETRANGE(Code, "Risk Department");
                // IF DimVal.FINDFIRST THEN
                //     "Risk Department Description" := DimVal.Name;

                // GetChampionUserID;
            end;
        }
        field(30; "Risk Department Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "HOD User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Risk Region"; Code[30])
        {

            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), "Dimension Value Type" = filter(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
            // DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            // trigger OnValidate()
            // begin
            //     DimVal.RESET;
            //     DimVal.SETRANGE("Global Dimension No.", 1);
            //     DimVal.SETRANGE(Code, "Risk Region");
            //     IF DimVal.FINDFIRST THEN
            //         "Risk Region Name" := DimVal.Name;
            //     GetChampionUserID;
            // end;
        }
        field(33; "Risk Region Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Review Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Assessment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(37; "Linked Incident"; Code[50])
        {
            TableRelation = "User Support Incident";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UserSupp: Record "User Support Incident";
            begin
                IF UserSupp.GET(Rec."Linked Incident") THEN BEGIN
                    "Linked Incident Description" := UserSupp."Incident Description";
                END;
            end;
        }

        field(38; "Rejection Reason"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(39; "Mark Okay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Linked Incident Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Risk Probability"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            trigger OnValidate()
            begin
                if ("Risk Probability" < 0) or ("Risk Probability" > 100) then Error(ValueError);
                RiskLikelihood.Reset();
                RiskLikelihood.SetFilter("Probability Start Range", '<=%1', "Risk Probability");
                RiskLikelihood.SetFilter(Probability, '>=%1', "Risk Probability");
                IF RiskLikelihood.FindFirst() then begin
                    "Risk Likelihood" := RiskLikelihood.Code;
                    "Risk Likelihood Value" := RiskLikelihood."Likelihood Score";
                    Validate("Risk Likelihood Value");
                    Validate("Risk Impact Value");
                    Validate("Residual Likelihood Impact");
                end;
            end;
        }
        field(42; "RAG Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","VERY HIGH",HIGH,AMBER,LOW;
            OptionCaption = ' ,VERY HIGH,HIGH,AMBER,GREEN';
        }
        field(43; "Value after Control"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            trigger OnValidate()
            begin
                RiskImpact.Reset();
                RiskImpact.SetFilter("Financial start", '<=%1', "Value after Control");
                RiskImpact.SetFilter("Financial End", '>=%1', "Value after Control");
                IF RiskImpact.FindFirst() then begin
                    "Control Evaluation Impact" := RiskImpact."Impact Score";
                    "Control Risk Impact" := RiskImpact.Code;
                    Validate("Control Evaluation Impact");
                    Validate("Control Risk Impact");
                    Validate("Control Evaluation Likelihood");
                    Validate("Control Risk (L * I)");
                    Validate("Residual Value");
                    "Residual Value" := "Value at Risk" - "Value after Control";
                    IF "Residual Value" < 1 THEN
                        "Residual Value" := 0;

                end;

            end;
        }
        field(44; "Control Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
            InitValue = '';

            trigger OnValidate()
            begin
                IF RiskLikelihood.GET("Control Risk Likelihood") THEN
                    "Control Evaluation Likelihood" := RiskLikelihood."Likelihood Score";
                VALIDATE("Control Evaluation Likelihood");
            end;
        }
        field(45; "Control Risk Impact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            InitValue = '';

            trigger OnValidate()
            begin
                IF RiskImpact.GET("Control Risk Impact") THEN
                    "Control Evaluation Impact" := RiskImpact."Impact Score";
                VALIDATE("Control Evaluation Impact");

                //"Residual Likelihood Impact" := ("Risk Impact Value" - "Control Evaluation Impact");

                // IF "Residual Likelihood Impact" < 1 THEN
                //     "Residual Likelihood Impact" := 1;
            end;
        }
        field(46; "Control Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                RAGSetup.Reset();
                RAGSetup.SetFilter("Gross Risk start", '<=%1', "Control Risk (L * I)");
                RAGSetup.SetFilter("Gross Risk end", '>=%1', "Control Risk (L * I)");
                IF RAGSetup.FindFirst() then begin
                    "Control RAG Status" := RAGSetup.Option;
                end;
            end;
        }
        field(47; "Control RAG Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","VERY HIGH",HIGH,AMBER,LOW;
            OptionCaption = ' ,VERY HIGH,HIGH,AMBER,LOW';
        }
        field(48; "Control Risk Probability"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            trigger OnValidate()
            begin
                if ("Control Risk Probability" < 0) or ("Control Risk Probability" > 100) then Error(ValueError);
                RiskLikelihood.Reset();
                RiskLikelihood.SetFilter("Probability Start Range", '<=%1', "Control Risk Probability");
                RiskLikelihood.SetFilter(Probability, '>=%1', "Control Risk Probability");
                IF RiskLikelihood.FindFirst() then begin
                    "Control Risk Likelihood" := RiskLikelihood.Code;
                    "Control Evaluation Likelihood" := RiskLikelihood."Likelihood Score";
                    Validate("Control Evaluation Likelihood");
                    Validate("Control Evaluation Impact");
                    Validate("Control Risk (L * I)");
                    Validate("Residual Risk Likelihood");
                end;
            end;
        }
        field(49; "Residual RAG Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","VERY HIGH",HIGH,AMBER,LOW;
            OptionCaption = ' ,VERY HIGH,HIGH,AMBER,GREEN';
        }
        field(50; "Residual Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            trigger OnValidate()
            begin
                RiskImpact.Reset();
                RiskImpact.SetFilter("Financial start", '<=%1', "Residual Value");
                RiskImpact.SetFilter("Financial End", '>=%1', "Residual Value");
                IF RiskImpact.FindFirst() then begin
                    "Residual Likelihood Impact" := RiskImpact."Impact Score";
                    "Residual Risk Impact" := RiskImpact.Code;
                    Validate("Residual Likelihood Impact");
                    Validate("Residual Risk Likelihood");
                    Validate("Residual Risk (L * I)");
                    "Residual Value" := "Value at Risk" - "Value after Control";
                    IF "Residual Value" < 1 THEN
                        "Residual Value" := 0;

                end;

            end;

        }
        field(51; "Risk Description2"; Text[1000])
        {
            //ObsoleteState = Removed;
            DataClassification = ToBeClassified;
            TableRelation = "Risk Objectives" where(Status = filter(Active));
            trigger OnValidate()
            var
                ObjRiskObj: Record "Risk Objectives";
            begin
                if ObjRiskObj.Get("Risk Description2") then
                    Description := ObjRiskObj."Objective Description";
                "Funtion Code" := ObjRiskObj."Function Code";
                "Function Description" := ObjRiskObj."Function Description";
            end;
        }
        field(52; "Additional mitigation controls"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Risk Acceptance Decision"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Treat,Tolerate,Terminate,Transfer;
            OptionCaption = ' ,Treat,Tolerate,Terminate,Transfer';
        }
        field(54; "Residual Risk Likelihood Cat"; Code[20])
        {
            Caption = 'Residual Risk Likelihood';
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
            InitValue = '';

        }
        field(55; "Residual Risk Impact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            InitValue = '';

        }
        field(56; "Root Cause Analysis"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Mitigation Suggestions"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Existing Risk Controls"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Risk Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories" where(Type = const(Type));
            trigger OnValidate()
            begin

                IF RiskCategory.GET("Risk Type") THEN
                    "Risk Type Description" := RiskCategory.Description;
            end;
        }
        field(60; "Risk Type Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(61; Comment; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Mitigation Owner"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Risk Area"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Risk Result"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(65; Auditor; Code[90])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "HRM-Employee C" where("Employment Type" = filter(Contract | Permanent));
            TableRelation = "Internal Audit Champions"."Employee No." where(Type = filter("Risk Owner"));
            trigger OnValidate()
            var
                objrisk: record "Internal Audit Champions";
            begin
                objrisk.Reset();
                objrisk.SetRange(objrisk."Escalator ID", Auditor);
                if objrisk.FindFirst() then begin
                    "Auditor Name" := objrisk."Risk Owner Name";
                    "Auditor Email" := objrisk."Risk Owner E-Mail";
                end;

            end;

        }
        field(66; "Auditor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Auditor Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Employee Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69; Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70; Submission; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Total Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Details" where("Risk Details Line" = field("No.")));
        }
        field(72; "Plan Type"; Option)
        {
            optionMembers = "Department Plan","Organizational Plan";
        }
        field(73; "Current Disposal"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Header" where("Current Plan" = const(true));
        }
        field(74; "Current Plan"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                CurrentCount: integer;
            begin
                CurrentCount := 0;
                ObjRiskHeader.Reset();
                ;
                ObjRiskHeader.SetRange(ObjRiskHeader."Current Plan", true);
                ObjRiskHeader.SetRange(ObjRiskHeader.Status, ObjRiskHeader.Status::New);
                if ObjRiskHeader.FindSet() then begin
                    repeat
                        CurrentCount += 1;
                    until ObjRiskHeader.Next() = 0;
                end;
                if CurrentCount > 1 then Error('current count cannot be greater than 1');
                if "Plan Type" = "Plan Type"::"Organizational Plan" then begin
                    RiskSetup.get;
                    RiskSetup."Current Risk Plan" := "No.";
                    RiskSetup.Modify();
                    //   "Current Disposal":=
                end
            end;
        }
        field(75; "Consolidate to HQ"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Consolidateion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Sent to HQ"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Audit Period"; Text[90])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Period";
            trigger OnValidate()
            var
                AuditSetUp: Record "Audit Setup";
                Noserieslines: Record "No. Series Line";
                ObjRiskHeader: Record "Risk Header";
            begin

                AuditSetUp.Get;
                ObjRiskHeader.Reset;
                ObjRiskHeader.SetRange(ObjRiskHeader."No.", "No.");
                if ObjRiskHeader.FindFirst then begin

                    //Department Risk No
                    Noserieslines.Reset();
                    Noserieslines.SetRange("Series Code", AuditSetUp."Department Risk No");
                    if Noserieslines.FindFirst() then begin

                        if Noserieslines."Last No. Used" <> '' then begin
                            "Risk No" := "Station Code" + '/' + 'RISK' + '/' + IncStr(Noserieslines."Last No. Used") + '/' + "Audit Period";
                            Noserieslines."Last No. Used" := IncStr(Noserieslines."Last No. Used");
                            Noserieslines.Modify();
                        end else begin
                            "Risk No" := "Shortcut Dimension 1 Code" + '/' + 'RISK' + '/' + Noserieslines."Starting No." + '/' + "Audit Period";
                            Noserieslines."Last No. Used" := Noserieslines."Starting No.";
                            Noserieslines.Modify();
                        end;
                    end;
                    //Region Risk No
                    Noserieslines.Reset();
                    Noserieslines.SetRange("Series Code", AuditSetUp."Region Risk No");
                    if Noserieslines.FindFirst() then begin

                        if Noserieslines."Last No. Used" <> '' then begin
                            "Region Risk No" := "Station Code" + '/' + 'RISK' + '/' + IncStr(Noserieslines."Last No. Used") + '/' + "Audit Period";
                            Noserieslines."Last No. Used" := IncStr(Noserieslines."Last No. Used");
                            Noserieslines.Modify();
                        end else begin
                            "Region Risk No" := Region + '/' + 'RISK' + '/' + Noserieslines."Starting No." + '/' + "Audit Period";
                            Noserieslines."Last No. Used" := Noserieslines."Starting No.";
                            Noserieslines.Modify();
                        end;
                    end;

                end;

            end;
        }
        field(79; "Station Code"; Code[90])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Risk No"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Region Risk No"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Region"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Station Name"; Code[190])
        {
            DataClassification = ToBeClassified;
        }
        field(84; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Reason For Changes"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        // "Retail Dealers Number" := "Retail Dealers No" + '/' + Format("Application Year");
        field(86; "Funtion Code"; Code[90])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Function Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Reason To Make Changes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "No.", Auditor)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description)
        {
        }
    }
    trigger OnDelete()
    begin
        Error('You Are Not Allowed To Delete A Record');
    end;

    trigger OnModify()
    begin
        if "Document Status" = "Document Status"::"Risk Manager" then begin

        end;

    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            RiskSetup.Get();
            RiskSetup.TESTFIELD("Risk Nos.");
            NoSeriesMgt.InitSeries(RiskSetup."Risk Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        end;

        if "Created By" = '' then begin
            "Created By" := UserId;
        end;

        "Date Created" := TODAY;

        // Fetch the user setup for the person creating the record (Risk Champion)
        IF UserSetup.GET("Created By") THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            "Employee No." := UserSetup."Employee No."; // Assign the Risk Champion's Employee No.
            //"Employee Name" := UserSetup."Full Name";   // Assign the Risk Champion's Name
            "Employee Email" := UserSetup."E-Mail";     // Assign the Risk Champion's Email
            "Station Code" := UserSetup."Global Dimension 1 Code";
            //"Station Name" := UserSetup."Station Name";
            "Risk Department" := UserSetup."Global Dimension 1 Code";
            UserSetup.Validate("Global Dimension 1 Code");
            //"Shortcut Dimension 1 Code" := UserSetup."Department Code";
            // UserSetup.Validate("Shortcut Dimension 1 Code");

        END;

    end;


    var
        ObjRiskChamps: Record "Internal Audit Champions";
        RiskSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        Employee: Record "HRM-Employee C";
        RiskCategory: Record "Risk Categories";
        RiskImpact: Record "Risk Impacts";
        RiskLikelihood: Record "Risk Likelihood";
        DimMgt: Codeunit DimensionManagement;
        DimVal: Record "Dimension Value";
        RAGSetup: Record "Risk RAG Status";
        LineNo: Integer;
        DocNo: Code[25];
        ValueError: Label 'Probability should be between 0 and 100';
        StaffNo: code[50];
        ObjUSstp: Record "User Setup";
        CurrentYEar: integer;
        ObjRiskHeader: Record "Risk Header";
        CuNoSersmgmt: codeunit NoSeriesManagement;
        ObjRiskDetails: Record "Risk Details";
        ObjRiskDetailsII: Record "Risk Details";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //     DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //     DimMgt.SaveDefaultDim(DATABASE::Employee, "No.", FieldNumber, ShortcutDimCode);
        //  //   MODIFY;
    end;

    local procedure GetChampionUserID()
    var
        RiskChampion: Record "Internal Audit Champions";
    begin
        RiskChampion.Reset();
        RiskChampion.SetRange("Shortcut Dimension 1 Code", "Risk Region");
        if RiskChampion.FindFirst() then
            "HOD User ID" := RiskChampion."User ID";
        "Risk Region" := RiskChampion."Shortcut Dimension 1 Code";
        Validate("Risk Region");
    end;

    procedure fnGetStaffNo(): Text
    begin
        ObjUSstp.Reset();
        ObjUSstp.SetRange(ObjUSstp."User ID", UserId);
        if ObjUSstp.FindFirst() then begin
            exit(ObjUSstp."Employee No.");
        end;
    end;

    procedure fnConsolidateRisk() Created: Boolean
    begin

        DocNo := '';
        LineNo := 0;
        StaffNo := '';
        StaffNo := fnGetStaffNo();
        CurrentYEar := 0;
        CurrentYEar := Date2DMY(Today, 3);
        RiskSetup.Get();
        RiskSetup.TestField(RiskSetup."Current Risk Plan");
        ObjRiskHeader.Reset();
        if ObjRiskHeader.Get(RiskSetup."Current Risk Plan") then begin
            if ObjRiskHeader.Status <> ObjRiskHeader.Status::New then begin
                Error('Current plan status must be open');
            end;
        end;
        RiskSetup.Get();
        ObjRiskHeader.Reset();
        ObjRiskHeader.SetRange(ObjRiskHeader."Plan Type", ObjRiskHeader."Plan Type"::"Organizational Plan");
        ObjRiskHeader.SetRange(ObjRiskHeader."No.", RiskSetup."Current Risk Plan");
        if ObjRiskHeader.FindLast() then begin
            DocNo := ObjRiskHeader."No.";
            ObjRiskHeader."Plan Type" := ObjRiskHeader."Plan Type"::"Organizational Plan";
        end else begin
            DocNo := CuNoSersmgmt.GetNextNo(RiskSetup."Risk Nos.", 0D, true);

            ObjRiskHeader.Init();
            ObjRiskHeader."No." := DocNo;
            if ObjRiskHeader.Insert(true) then Created := true;
        end;
        ObjRiskDetailsII.Reset();
        if ObjRiskDetailsII.Find('+') then
            LineNo := ObjRiskDetailsII."Line No" + 1
        else
            LineNo := 1;
        ObjRiskDetails.Reset();
        ObjRiskDetails.SetRange(ObjRiskDetails."Risk No.", "No.");
        if ObjRiskDetails.FindSet() then begin
            repeat

                //  Message('Doc No %1', DocNo);

                ObjRiskDetailsII.Init();
                ObjRiskDetailsII.TransferFields(ObjRiskDetails);
                ObjRiskDetailsII."Risk No." := DocNo;
                ObjRiskDetailsII."Consolidated Records" := true;
                // ObjRiskDetailsII.Objective := 'Okune1';
                // ObjRiskDetailsII.Description := 'Okune1';
                // ObjRiskDetailsII."Shortcut Dimension 1 Code" := 'Okune1';
                // ObjRiskDetailsII."Risk Category" := ObjRiskDetails."Risk Category";
                // ObjRiskDetailsII."Risk Category Description" := ObjRiskDetails."Risk Category Description";
                // ObjRiskDetailsII."Risk Type" := ObjRiskDetails."Risk Type Description";
                // ObjRiskDetailsII."Line No" := LineNo + 1;
                // ObjRiskDetailsII."Risk Descriptions" := ObjRiskDetails."Risk Descriptions";
                // ObjRiskDetailsII."Risk Likelihood" := ObjRiskDetails."Risk Likelihood";
                // ObjRiskDetailsII."Risk Likelihood Value" := ObjRiskDetails."Risk Likelihood Value";
                // ObjRiskDetailsII."Risk Impact" := ObjRiskDetails."Risk Impact";
                // ObjRiskDetailsII."Risk Impact Value" := ObjRiskDetails."Risk Impact Value";
                // ObjRiskDetailsII."Risk (L * I)" := ObjRiskDetails."Risk (L * I)";
                // ObjRiskDetailsII."Mitigation Suggestions2" := ObjRiskDetails."Mitigation Suggestions2";
                // ObjRiskDetailsII."Root Cause Analysis2" := ObjRiskDetails."Root Cause Analysis2";
                if ObjRiskDetailsII.Insert(true) then Created := true;
                Commit();
            until ObjRiskDetails.Next() = 0;
        end;
        if Created then begin
            "Consolidate to HQ" := true;
            Modify();
        end;
        exit(Created);

    end;

}

