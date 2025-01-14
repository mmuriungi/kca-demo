table 52178725 "Proc-Purchase Quote Header"
{
    DataCaptionFields = "No.";
    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(2; "Document Type"; Enum "Purchase Document Type")
        {
        }

        field(3; "Requisition No."; code[30])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = filter(Quote), DocApprovalType = filter(Requisition), Status = filter(Released), Archived = filter(false));
            trigger OnValidate()
            var
                RFQ: Record "PROC-Purchase Quote Line";
                RFQ_Line: Record "PROC-Purchase Quote Line";
                countedRec: Integer;
                PurchLine: Record "Purchase Line";
                purheader: Record "Purchase Header";
            begin
                //CHECK WHETHER HAS LINES AND DELETE
                IF NOT CONFIRM('If you change the purchase requisition No. the current lines will be deleted. Do you want to continue?', FALSE)
                THEN
                    ERROR('You have selected to abort the process');

                RFQ_Line.RESET;
                RFQ_Line.SETRANGE("Document No.", "No.");
                RFQ_Line.DELETEALL;

                PurchLine.RESET;
                PurchLine.SETRANGE("Document No.", "Requisition No.");
                IF PurchLine.FIND('-') THEN BEGIN
                    REPEAT
                        RFQ_Line.Reset();
                        RFQ_Line.SetRange("Document No.", "No.");
                        if RFQ_Line.Find('-') then begin
                            countedRec := RFQ_Line.COUNT + 1;
                        end
                        else
                            countedRec := 1;

                        RFQ_Line.Init();
                        RFQ_Line."Document No." := Rec."No.";
                        RFQ_Line."Document Type" := RFQ_Line."Document Type"::Quote;
                        //RFQ_Line."Line No." := countedRec;
                        RFQ_Line."Unit of Measure" := PurchLine."Unit of Measure";
                        RFQ_Line."Type" := PurchLine."Type";
                        RFQ_Line."No." := PurchLine."No.";
                        rfq_line."Order Date" := rec."Document Date";
                        RFQ_Line."Line No." := PurchLine."Line No.";
                        RFQ_Line."Location Code" := PurchLine."Location Code";
                        RFQ_Line.Quantity := PurchLine.Quantity;
                        RFQ_Line.Description := PurchLine.Description;
                        RFQ_Line."Description 2" := PurchLine."Description 2";
                        RFQ_Line."Direct Unit Cost" := PurchLine."Direct Unit Cost";
                        RFQ_Line."Line Amount" := PurchLine.Amount;
                        RFQ_Line.Insert();

                    UNTIL PurchLine.NEXT = 0;
                END;
            end;
        }
        field(4; "Suppliers Category"; code[50])
        {
            TableRelation = "Proc-Prequalif. Categories"."Category Code" where("Preq Year" = field("Prequalification Period"));
            trigger OnValidate()
            var
                vcategory: Record "Proc-Prequalif. Categories";
            begin
                vcategory.Reset();
                vcategory.SetRange("Category Code", "Suppliers Category");
                if vcategory.Find('-') then begin
                    "Category Description" := vcategory.Description;
                end;
            end;

        }
        field(5; "Category Description"; Text[100])
        {

        }

        field(6; "Prequalification Period"; Code[30])
        {
            TableRelation = "Proc-Prequalification Years"."Preq. Year";
        }

        field(7; "Expected Opening Date"; DateTime)
        {
            Caption = 'Expected Opening Date';
            trigger OnValidate()
            begin
                if "Expected Closing Date" > "Expected Opening Date" then
                    error('Closing date can not be later than opening date')
            end;
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(9; "Expected Closing Date"; DateTime)
        {
            Caption = 'Expected Closing Date';
        }
        field(10; "Expected Opening Date II"; DateTime)
        {

            trigger OnValidate()
            begin
                if "Expected Closing Date II" > "Expected Opening Date II" then
                    error('Closing date can not be later than opening date')
            end;
        }
        field(11; "Expected Closing Date II"; DateTime)
        {

        }
        field(12; "Description"; Text[1000])
        {
            Caption = 'Description';
        }
        field(13; "Procurement methods"; Enum "Proc-Procurement Methods")
        {

        }
        field(14; "Initiate Tier Two"; Boolean)
        {

        }
        field(15; "Professional Opinion"; Text[2000])
        {
            trigger OnValidate()
            begin
                "captured by" := UserId;
            end;
        }
        field(16; "Awarded BId"; Code[10])
        {
            TableRelation = "Tender Submission Header"."No." where("Request for Quote No." = field("No."), "Bid Status" = filter("Fin Qualif"));
            trigger OnValidate()
            var
                tsubmission: Record "Tender Submission Header";
            begin
                tsubmission.Reset();
                tsubmission.SetRange("No.", rec."Awarded BId");
                if tsubmission.Find('-') then begin
                    "Bidder/Supplier" := tsubmission."Bidder No";
                end;

            end;
        }

        field(17; "Awarded Quote"; Code[10])
        {
            TableRelation = "Purchase Header"."No." where("Request for Quote No." = field("No."), "Quote Status" = filter("Fin Qualif"));
            trigger OnValidate()
            var
                purhead: Record "Purchase Header";
            begin
                purhead.Reset();
                purhead.SetRange("No.", rec."Awarded Quote");
                if purhead.Find('-') then begin
                    "Bidder/Supplier" := purhead."Buy-from Vendor No.";
                end;

            end;
        }
        field(18; "Issue Order"; Boolean)
        {

        }
        field(19; "Bidder/Supplier"; Code[30])
        {

        }
        field(20; "captured by"; Code[30])
        {

        }
        field(21; "Order No."; Code[30])
        {

        }

        field(22; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(24; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }

        field(25; Status; Option)
        {

            Editable = false;
            OptionMembers = Open,Released,"Pending Approval",Closed,Cancelled;
        }

        field(26; "Quote No."; Code[20])
        {

            Editable = false;
        }
        field(27; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }

        field(28; "UserName"; Code[20])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";
        }

        field(29; DocApprovalType; Option)
        {
            OptionMembers = Purchase,Requisition,Quote;
        }

        field(30; "Created By"; Code[20])
        {
        }

        field(31; "Vendor Quote No."; Code[20])
        {

        }
        field(32; "Technical Evaluation"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(33; "Technical Passmark Score"; Decimal)
        {
            Editable = false;
            BlankZero = false;
            DecimalPlaces = 1;
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Technical Qualif"."Maximum Score" where("No." = field("No.")));
            trigger OnValidate()
            begin
                if "Technical Passmark Score" > 100 then Error('The score cannot exceed 100!');
            end;


        }
        field(34; "Demonistration Evaluation"; Option)
        {
            Caption = 'Demonstration Evaluation';
            OptionMembers = No,Yes;
        }
        field(35; "Demo Passmark Score"; Decimal)
        {
            BlankZero = false;
            DecimalPlaces = 1;
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Demo Qualif"."Maximum Score" where("No." = field("No.")));
            trigger OnValidate()
            begin
                if "Demo Passmark Score" > 100 then Error('The score cannot exceed 100!');
            end;
        }
        field(36; "Financial Evaluation Score"; Decimal)
        {
            Caption = 'Financial Evaluation Amount';
            FieldClass = FlowField;
            CalcFormula = sum("PROC-Purchase Quote Line"."Line Amount" where("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Editable = false;
        }
        field(37; "Post-Qualification"; Option)
        {
            OptionMembers = No,Yes;
        }

        field(39; "Has Evaluation"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(40; "Preliminary Evaluation"; Option)
        {
            OptionMembers = No,Yes;
            trigger OnValidate()
            begin
                if "Preliminary Evaluation" = "Preliminary Evaluation"::Yes then begin
                    PreliQual.Reset();
                    PreliQual.SetRange("No.", rec."No.");
                    if PreliQual.Find('-') then begin
                        PreliQual.Delete();
                    end;
                    ClassReq.Reset();
                    ClassReq.SetRange(Code, rec."Suppliers Category");
                    ClassReq.SetFilter("Line No", '<>%1', 0);
                    if ClassReq.FindSet() then begin
                        repeat
                            PreliQual.Reset();
                            PreliQual.SetRange("No.", rec."No.");
                            PreliQual.Setrange("Entry No.", ClassReq."Line No");
                            if not PreliQual.Find('-') then begin
                                PreliQual."Entry No." := ClassReq."Line No";
                                PreliQual."No." := rec."No.";
                                PreliQual.Description := ClassReq.Description;
                                if ClassReq.Mandatory = ClassReq.Mandatory::Yes then
                                    PreliQual.Mandatory := true;
                                PreliQual.Insert()
                            end else begin
                                PreliQual."Entry No." := ClassReq."Line No";
                                PreliQual."No." := rec."No.";
                                PreliQual.Description := ClassReq.Description;
                                if ClassReq.Mandatory = ClassReq.Mandatory::Yes then
                                    PreliQual.Mandatory := true;
                                PreliQual.Modify()
                            end;

                        until ClassReq.Next() = 0;
                    end;
                end;
                if "Preliminary Evaluation" = "Preliminary Evaluation"::No then begin
                    PreliQual.Reset();
                    PreliQual.SetRange("No.", rec."No.");
                    if PreliQual.Find('-') then
                        PreliQual.Delete();
                end;

            end;

        }
        field(41; "Financial Evaluation"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(42; "Evaluation Started"; Boolean)
        {

        }
        field(43; "Advert Date"; Date)
        {

        }
        field(44; "Total Quotes"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Request for Quote No." = field("No.")));
        }

    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Quotation Request No");  // Notice the period after No
            "No." := NoSeriesMgt.GetNextNo(PurchSetup."Quotation Request No", WorkDate(), true);
        end;
    end;

    trigger OnModify()
    begin

    end;


    procedure SendMail();
    var
        vends: Record "PROC-Quotation Request Vendors";
        Vendor: Record Vendor;
        EmailMessage: Codeunit "Email Message";
        ProcHead: Record "Proc-Purchase Quote Header";
        Body: Text;
        Email: Codeunit Email;
        Subject: Text;
        Recipients: List of [Text];
        CompanyInfo: Record "Company Information";
        EmailInStream: InStream;
        EmailOutStream: OutStream;
        tempBlob: Codeunit "Temp Blob";
        AttachmentInStream: InStream;
        AttachmentOutStream: OutStream;
        TaskMessage: Label 'Request For Quotation';
        TaskSubject: Label 'Dear, %1<br></br> You are hereby requested to submit your quotation for %2 %3 (Attached) via the portal by using <a href =http://vendor.psasb.go.ke:81/> http://vendor.psasb.go.ke:81/ </a>';
        RecordRef: RecordRef;
    begin
        ProcHead.Reset();
        ProcHead.SetRange("No.", rec."No.");
        if ProcHead.Find('-') then begin
            vends.Reset();
            vends.SetRange("Document No.", ProcHead."No.");
            if vends.Find('-') then begin
                Clear(AttachmentInStream);
                Clear(AttachmentOutStream);
                Clear(EmailMessage);
                Clear(Email);
                repeat
                    Vendor.Reset();
                    Vendor.SetRange("No.", vends."Vendor No.");
                    if Vendor.Find('-') then begin
                        Recipients.Add(Vendor."E-Mail");
                        TempBlob.CreateOutStream(AttachmentOutStream);
                        RecordRef.GetTable(ProcHead);
                        Report.SaveAs(report::"RFQ Report 1", Vendor.Name, ReportFormat::Pdf, AttachmentOutStream, RecordRef);
                        TempBlob.CreateInStream(AttachmentInStream);
                        Subject := StrSubstNo(TaskMessage);
                        Body := StrSubstNo(TaskSubject, Vendor.Name, rec."No.", rec.Description);
                        EmailMessage.Create(Recipients, Subject, Body, true);
                        EmailMessage.AddAttachment(Vendor.Name + '.pdf', 'PDF', AttachmentInStream);
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Notification);
                    end;
                until vends.Next() = 0;
            end;
        end;

    end;



    procedure fetchVendors()
    var
        ven: Record "Proc-Preq. Suppliers/Category";
        vengry: Record "RFQ Suppliers Category";
        RFQ: Record "PROC-Purchase Quote Header";
    begin
        RFQ.Reset();
        RFQ.SetRange("No.", Rec."No.");
        RFQ.SetRange("Suppliers Category", Rec."Suppliers Category");
        if RFQ.Find('-') then begin
            vengry.Reset();
            vengry.SetRange("Document No.", RFQ."No.");
            vengry.DeleteAll();

            ven.Reset();
            ven.SetRange("Preq. Category", RFQ."Suppliers Category");
            if ven.Find('-') then begin

                repeat
                    ven.CalcFields("Supplier Name", Phone, Email);
                    vengry.Init();
                    vengry."Document No." := RFQ."No.";
                    vengry."Supplier No" := ven.Supplier_Code;
                    vengry."Supplier Name" := ven."Supplier Name";
                    vengry.Email := ven.Email;
                    vengry."Telephone No." := ven.Phone;
                    vengry."Prequalification Period" := ven."Preq. Year";
                    vengry.Insert();
                until ven.Next() = 0;

                vengry.Reset();
                vengry.SetRange("Document No.", RFQ."No.");
                page.Run(Page::"RFQ Category Suppliers", vengry);

            end;


        end;

    end;


    procedure PreliminaryChecks()
    var
        techQual: Record "Proc-Technical Qualif";
    begin
        if Rec."Technical Evaluation" = Rec."Technical Evaluation"::Yes then begin
            if "Technical Passmark Score" <= 0 then Error('Technical Passmark has to be above zero');
            if "Technical Passmark Score" > 100 then Error('Technical Passmark has to be 100 and below');
        end;
        if Rec."Demonistration Evaluation" = Rec."Demonistration Evaluation"::Yes then begin
            if "Demo Passmark Score" <= 0 then Error('Demo Passmark has to be above zero');
            if "Demo Passmark Score" > 100 then Error('Demo Passmark has to be 100 and below');
        end;
        techQual.Reset();
        techQual.SetRange("No.", Rec."No.");
        if techQual.Find('-') then begin
            repeat
                if techQual."Maximum Score" <= 0 then
                    Error('%1%2%3%4%5', 'Technical Requirement ', techQual.Description, ' has to have a maximum score ');
            until techQual.Next() = 0;

        end;
    end;


    var
        eval: Record "Proc Evaluation Report";
        confrm: Record "Proc-Confirm Recommended";
        committe: Record "Proc-Committee Membership";
        Pheader: Record "Purchase Header";

        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ClassReq: Record "Proc Classification Requiremnt";
        PreliQual: Record "Proc-Preliminary Qualif";
}