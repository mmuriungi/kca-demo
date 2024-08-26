page 51479 "POS Sales Staff"
{
    PageType = Card;
    SourceTable = "POS Sales Header";
    RefreshOnActivate = true;
    SourceTableView = where("Customer Type" = filter(Staff), Posted = filter(false));
    layout
    {
        area(Content)
        {
            group(general)
            {
                Editable = not Rec.Posted;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Description field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }

                field("Current Date Time"; Rec."Current Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Date Time field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field("Amount Paid"; Rec."Amount Paid")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Paid field.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                    Visible = false;
                }

            }
            part(salesLines; "POS Sales Lines")
            {
                Editable = not Rec.Posted;
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Serving Category" = field("Customer Type"), "Posting Date" = field("Posting Date");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                Promoted = true;
                PromotedCategory = process;
                Image = Print;
                ShortcutKey = 'F9';
                Visible = false;
                trigger OnAction()
                var
                    RecRef: RecordRef;
                    saleheader2: Record "POS Sales Header";

                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(Report::"POS PrintOut", true, false, Rec);
                end;
            }
            action(Post)
            {
                Promoted = true;
                PromotedCategory = process;
                Image = Post;
                ShortcutKey = 'F11';
                Visible = false;
                trigger OnAction()
                var
                    RecRef: RecordRef;
                    saleheader2: Record "POS Sales Header";

                begin
                    ;
                end;
            }
            action("Post & Print")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = process;
                Image = PostApplication;
                ShortcutKey = 'F10';
                //Visible = false;
                trigger OnAction()
                begin
                    if Rec."Amount Paid" = 0 then
                        Error('Amount Paid Must Have a value');
                    CommonMgnt.PostSale(Rec."No.");
                    rec.Reset();

                    Rec.SetRange("No.", Rec."No.");
                    if rec.find('-') then begin
                        Report.Run(Report::"POS PrintOutTwo", false, true, Rec);
                        CurrPage.Close();

                    end;



                end;
            }
            action("PostIt")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                Image = "Invoicing-Document";
                Visible = false;

                trigger OnAction()
                var
                    saleheader: Record "POS Sales Header";
                begin
                    Rec.TestField("Total Amount");
                    Rec.TestField("Bank Account");
                    Rec.TestField("Income Account");
                    Rec.PostSale();
                end;

            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Customer Type", '=%1', Rec."Customer Type"::"Staff");
        PosSetup.GET;
        Rec."Posting Description" := 'Staff Food sales on ' + format(Today());
        Rec."Posting Date" := Today();
        Rec.Cashier := UserId;
        Rec."Customer Type" := Rec."Customer Type"::Staff;
        Rec."Current Date Time" := System.CurrentDateTime();

        Rec."Bank Account" := PosSetup."Staff Cashbook";
        Rec."Income Account" := PosSetup."Staff Sales Account";

    end;

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Customer Type", '=%1', Rec."Customer Type"::"Staff");
        PosSetup.GET;
        Rec."Posting Description" := 'Staff Food sales on ' + format(Today());
        Rec."Posting Date" := Today();
        Rec.Cashier := UserId;
        Rec."Customer Type" := Rec."Customer Type"::Staff;
        Rec."Current Date Time" := System.CurrentDateTime();

        Rec."Bank Account" := PosSetup."Staff Cashbook";
        Rec."Income Account" := PosSetup."Staff Sales Account";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF Rec."No." = '' THEN BEGIN
            PosSetup.GET;
            PosSetup.TESTFIELD(PosSetup."Sales No.");
            NoSeriesMgt.InitSeries(PosSetup."Sales No.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
            Rec."Posting Description" := 'Staff Food sales on ' + format(Today());
            Rec."Posting Date" := Today();
            Rec.Cashier := UserId;
            Rec."Customer Type" := Rec."Customer Type"::Staff;
            Rec."Current Date Time" := System.CurrentDateTime();

            Rec."Bank Account" := PosSetup."Staff Cashbook";
            Rec."Income Account" := PosSetup."Staff Sales Account";
        end

    end;

    trigger OnInit()
    begin
        Rec.SETFILTER("Customer Type", '=%1', Rec."Customer Type"::"Staff");
        PosSetup.GET;
        Rec."Posting Description" := 'Staff Food sales on ' + format(Today());
        Rec."Posting Date" := Today();
        Rec.Cashier := UserId;
        Rec."Customer Type" := Rec."Customer Type"::Staff;
        Rec."Current Date Time" := System.CurrentDateTime();
        Rec."Bank Account" := PosSetup."Staff Cashbook";
        Rec."Income Account" := PosSetup."Staff Sales Account";

    end;


    var
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        posLines: record "POS Sales Lines";
        GenJnLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        LineNo: Integer;
        itemledger: Record "POS Item Ledger";
        saleheader: Record "POS Sales Header";
        CommonMgnt: Codeunit "Common Management";

}
