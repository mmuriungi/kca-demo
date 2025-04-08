table 51297 "Audit Lines"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Audit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Audit;

            trigger OnValidate()
            begin

                IF Audit.GET("Audit Code") THEN BEGIN
                    "Audit Description" := Audit.Description;
                    "Audit Type" := Audit."Type of Audit";
                END;

                VALIDATE("Audit Type");
            end;
        }
        field(3; "Audit Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Assessment Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,High,Moderate,Low';
            OptionMembers = " ",High,Moderate,Low;
        }
        field(5; "Audit Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Types";

            trigger OnValidate()
            begin

                IF AuditType.GET("Audit Type") THEN
                    "Audit Type Description" := AuditType.Name;
            end;
        }
        field(6; "Audit Type Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Scheduled Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(10; "Scheduled End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Audit Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Objectives,Planning,Review,Post Reveiw,Scope,Auditor,WorkPaper Conclusion,WorkPaper Objectives,WorkPaper Result,Report Objectives,Report Opinion,Report Recommendation,Report Background,Report Observation,Internal Risk,External Risk,Risk Mitigation,Risk Opportunities,Audit Plan,Compliance,Report Workpapers,WorkPaper Scope';
            OptionMembers = " ",Objectives,Planning,Review,"Post Reveiw",Scope,Auditor,"WorkPaper Conclusion","WorkPaper Objectives","WorkPaper Result","Report Objectives","Report Opinion","Report Recommendation","Report Background","Report Observation","Internal Risk","External Risk","Risk Mitigation","Risk Opportunities","Audit Plan",Compliance,"Report Workpapers","WorkPaper Scope";
        }
        field(13; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Done By"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "WorkPlan Ref"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Comment; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Comment 1"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Differences Explained"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Reports Reviewed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Description; BLOB)
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Risk Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ",Low,Medium,High;
        }
        field(22; Reference; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Risk Implication"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Criteria; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Observation/Condition"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Action Plan / Mgt Response"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Responsible Personnel"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
        }
        field(29; Rating; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Rating";
            ObsoleteState = Removed;
        }
        field(30; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Responsible Personnel Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin

                IF Employee.GET("Responsible Personnel Code") THEN
                    "Responsible Personnel" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(33; "Reminder Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Risk Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF RiskCategory.GET("Risk Category") THEN
                    "Risk Category Description" := RiskCategory.Description;
            end;
        }
        field(35; "Risk Category Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Risk Impacts"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            ValidateTableRelation = false;
        }
        field(37; "Risk Mitigation"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Risk Opportunities"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(39; Frequency; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Compliance Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Title; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Description of Legislation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Relevant Legislation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(44; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(45; Auditor; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET(Auditor) THEN BEGIN
                    "Auditor Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                END;
            end;
        }
        field(46; "Auditor Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(47; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Scheduled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(49; Image; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50; Favourable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Description 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Scope Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Report Workpaper No."; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                AuditRec.RESET;
                AuditRec.SETRANGE(Type,AuditRec.Type::"Work Paper");
                AuditRec.SETRANGE("No.","Report Workpaper No.");
                IF AuditRec.FIND('-') THEN
                  BEGIN
                    AuditMgt.InsertWorkpaperObservationToAuditReport(AuditRec,"Document No.");
                  END;
                */

            end;
        }
        field(54; "Report Workpaper Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Program Scope"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "From Program No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Review Scope No."; Integer)
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Audit Lines" where("Audit Code" = field("Document No."));
            trigger OnValidate()
            begin
                if Rec.Get("Review Scope No.") then
                    "Review Scope" := Rec.Scope;
            end;
        }
        field(58; Review; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Review Scope Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Scope Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Description 2 Blob"; BLOB)
        {
            DataClassification = ToBeClassified;
            Description = 'Provides the place to input description of an Audit Review';
            
        }
        field(62; "Procedure Prepared By."; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Specifies the Reveiw Procedure User that prepared the review.';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(63; "Review Procedure Blob"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(64; Rating2; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                RatioSetup.SetRange("Risk Category", "Risk Category");
                if RatioSetup.Find('-') then begin
                    if (Rating2 > RatioSetup."Max.Rating") or (Rating2 < RatioSetup."Min.Rating") then
                        Error(RatingErr, RatioSetup."Min.Rating", RatioSetup."Max.Rating");
                end;

            end;
        }
        field(65; "Update Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Weekly,Monthly,Quaterly,Semi Annually,Annually';
            OptionMembers = " ",Daily,Weekly,Monthly,Quaterly,"Semi Annually",Annually;
        }
        field(66; "Update Stopped"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Update Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;

            trigger OnValidate()
            begin
                //DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(481; "KPI(s)"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(482; Cost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(483; "AREA"; Code[90])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Risk Details"."Risk No.";

            // trigger OnValidate()
            // begin
            //     ObjRiskDetails.Reset();
            //     ObjRiskDetails.SetRange(ObjRiskDetails."Risk No.", "AREA");
            //     if ObjRiskDetails.Find('-') then begin
            //         Department := ObjRiskDetails.Department;
            //         "Risk Category2" := ObjRiskDetails."Risk Category";
            //         "Risk Category Description2" := ObjRiskDetails."Risk Category Description";
            //         "Risk Type" := ObjRiskDetails."Risk Type";
            //         "Risk Type Description" := ObjRiskDetails."Risk Type Description";
            //         "Risk Likelihood" := ObjRiskDetails."Risk Likelihood";
            //         "Risk Likelihood Value" := ObjRiskDetails."Risk Likelihood Value";
            //         "Risk Impact" := ObjRiskDetails."Risk Impact";
            //         "Risk Impact Value" := ObjRiskDetails."Risk Impact Value";
            //         "Risk (L * I)" := ObjRiskDetails."Risk (L * I)";
            //     end;

            // end;

        }
        field(484; Department; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(485; "Risk Category2"; Code[30])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Risk Categories" where(Type = const(Category));

            // trigger OnValidate()
            // begin

            //     IF RiskCategory.GET("Risk Category") THEN
            //         "Risk Category Description" := RiskCategory.Description;
            // end;
        }
        field(486; "Risk Category Description2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(487; "Risk Type"; Code[50])
        {
            // DataClassification = ToBeClassified;
            // TableRelation = "Risk Categories" where(Type = const(Type));
            // trigger OnValidate()
            // begin

            //     IF RiskCategory.GET("Risk Type") THEN
            //         "Risk Type Description" := RiskCategory.Description;
            // end;
        }
        field(488; "Risk Type Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(489; "Risk Likelihood Value"; Decimal)
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
        field(490; "Risk Likelihood2"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Risk Evaluation Score".Description;

            // trigger OnValidate()
            // begin
            //     ObjRiskEve.Reset();
            //     ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Likelihood");
            //     IF ObjRiskEve.Find('-') THEN begin
            //         "Risk Likelihood Value" := ObjRiskEve.Score;
            //         //  VALIDATE("Risk Impact Value");
            //     end;
            // end;
        }
        field(491; "Risk Impact Value"; Decimal)
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
        field(492; "Risk (L * I)"; Decimal)
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

        field(493; "Risk Impact"; Code[60])
        {
            // TableRelation = "Risk Evaluation Score".Description;

            // trigger OnValidate()
            // begin
            //     ObjRiskEve.Reset();
            //     ObjRiskEve.SetRange(ObjRiskEve.Description, "Risk Impact");

            //     IF ObjRiskEve.Find('-') THEN begin
            //         "Risk Impact Value" := ObjRiskEve.Score;
            //         //  VALIDATE("Risk Impact Value");
            //     end;
            // end;
        }
        field(494; "Mitigation Suggestions"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(495; "Risk Description"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(496; "Root Cause Analysis"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(497; "Objective(s)"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(498; "Root Cause Analysis2"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(499; "Mitigation Suggestions2"; Text[1500])
        {
            DataClassification = ToBeClassified;

        }
        field(500; "Responsible Personnel Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(501; Scope; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(502; "Review Scope"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(503; "Workpaper Result"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(504; Objective; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(505; "W/P Ref"; Code[90])
        {
            DataClassification = ToBeClassified;
        }
        field(506; "Risk Descriptions"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(507; "CEO Comments"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(508; "Audit Stage"; Option)
        {
            OptionMembers = New,Council,Auditor;
            FieldClass = FlowField;
            CalcFormula = lookup("Audit Header"."Audit Stage" where("No." = FIELD("Document No.")));

        }
        field(509; Role; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(510; Consolidated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
     



    }

    keys
    {
        key(Key1; "Document No.", "Audit Line Type", "Audit Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();
    end;

    var

        RAGSetup: Record "Risk RAG Status";
        RiskImpact: Record "Risk Impacts";
        RiskLikelihood: Record "Risk Likelihood";
        ObjRiskEve: Record "Risk Evaluation Score";
        ObjRiskDetails: Record "Risk Details";
        ObjRiskHeader: Record "Risk Header";
        Employee: Record Employee;
        Audit: Record Audit;
        AuditType: Record "Audit Types";
        RiskCategory: Record "Risk Categories";
        AuditRec: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        RatioSetup: Record "Risk Ratio";
        RatingErr: Label 'Rating should be between %1 and %2';
    //DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    local procedure CalcDescriptionField(FieldID: Integer)
    begin
    end;

    procedure GetReviewScope(AuditLine: Record "Audit Lines")
    var
        ScopeList: Page "Select Scope - All";
        AuditLinesRec: Record "Audit Lines";
        AuditLineRecCopy: Record "Audit Lines";
        AuditLine2: Record "Audit Lines";
        AuditLineRecCopy2: Record "Audit Lines";
    begin
        AuditLinesRec.RESET;
        AuditLinesRec.SETRANGE("Document No.", AuditLine."Document No.");
        AuditLinesRec.SETRANGE("Audit Line Type", AuditLinesRec."Audit Line Type"::Scope);
        AuditLinesRec.SETRANGE("Review Scope Selected", FALSE);
        ScopeList.SETTABLEVIEW(AuditLinesRec);
        ScopeList.SetReview(TRUE);
        ScopeList.LOOKUPMODE(TRUE);
        IF ScopeList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            AuditLineRecCopy.COPY(AuditLinesRec);
            AuditLineRecCopy.SETRANGE("Review Scope Selected", TRUE);
            IF AuditLineRecCopy.FINDSET THEN BEGIN
                REPEAT
                    AuditLine2.INIT;
                    AuditLine2."Document No." := AuditLineRecCopy."Document No.";
                    AuditLine2."Audit Line Type" := AuditLine2."Audit Line Type"::Review;
                    AuditLine2."Line No." := GetNextLineNo;
                    AuditLine2."Review Scope No." := AuditLineRecCopy."Line No.";
                    AuditLineRecCopy.CALCFIELDS(Description);
                    AuditLine2.Description := AuditLineRecCopy.Description;
                    AuditLine2."Procedure Prepared By." := USERID;
                    //IF NOT CheckScopeNoExists(AuditLine2."Document No.",AuditLine2."Review Scope No.") THEN
                    AuditLine2.INSERT;
                UNTIL AuditLineRecCopy.NEXT = 0;
            END;

            //Set Review Scope Selected to false
            AuditLineRecCopy2.COPY(AuditLineRecCopy);
            WITH AuditLineRecCopy2 DO
                REPEAT
                    "Review Scope Selected" := FALSE;
                    MODIFY;
                UNTIL AuditLineRecCopy2.NEXT = 0;
        END;
    end;

    local procedure GetNextLineNo(): Integer
    var
        AuditLine: Record "Audit Lines";
    begin
        AuditLine.RESET;
        AuditLine.SETRANGE("Document No.", "Document No.");
        AuditLine.SETRANGE("Audit Line Type", AuditLine."Audit Line Type");
        IF AuditLine.FINDLAST THEN
            EXIT(AuditLine."Line No." + 1)
        ELSE
            EXIT(1);
    end;

    local procedure CheckScopeNoExists(DocNo: Code[50]; ScopeLineNo: Integer): Boolean
    var
        AuditLineRec: Record "Audit Lines";
    begin
        AuditLineRec.RESET;
        AuditLineRec.SETRANGE("Document No.", DocNo);
        AuditLineRec.SETRANGE("Audit Line Type", AuditLineRec."Audit Line Type"::Review);
        AuditLineRec.SETRANGE("Review Scope No.", ScopeLineNo);
        IF AuditLineRec.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
}

