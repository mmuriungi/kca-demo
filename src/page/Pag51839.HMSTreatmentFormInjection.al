page 51839 "HMS-Treatment Form Injection"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment Form Injection";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Injection No."; Rec."Injection No.")
                {
                    ApplicationArea = All;
                }
                // field("Item No."; Rec."Item No.")
                // {
                //     ApplicationArea = All;
                // }
                // field(Location; Rec.Location)
                // {
                //     ApplicationArea = All;
                // }
                field("Injection Name"; Rec."Injection Name")
                {
                    ApplicationArea = All;
                }
                field("Injection Given"; Rec."Injection Given")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    Caption = 'Charge';
                    ApplicationArea = All;
                }

                // field("Injection Unit of Measure"; Rec."Injection Unit of Measure")
                // {
                //     ApplicationArea = All;
                // }
                // field("Injection Quantity"; Rec."Injection Quantity")
                // {
                //     ApplicationArea = All;
                // }
                // field(Duration; Rec.Duration)
                // {
                //     ApplicationArea = All;
                // }
                field("Injection Remarks"; Rec."Injection Remarks")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Post Item Usage")
            {
                Caption = '&Post Item Usage';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you wish to post the record?', FALSE) = FALSE THEN BEGIN EXIT END;
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    ItemJnlLine.RESET;
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", HMSSetup."Doctor Item Journal Template");
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", HMSSetup."Doctor Item Journal Batch");
                    IF ItemJnlLine.FIND('-') THEN ItemJnlLine.DELETEALL;
                    LineNo := 1000;
                    PharmLine.RESET;
                    PharmLine.SETRANGE(PharmLine."Treatment No.", Rec."Treatment No.");
                    PharmLine.SETRANGE(PharmLine.Posted, FALSE);
                    IF PharmLine.FIND('-') THEN BEGIN
                        REPEAT

                            ItemJnlLine.INIT;
                            ItemJnlLine."Journal Template Name" := HMSSetup."Doctor Item Journal Template";
                            ItemJnlLine."Journal Batch Name" := HMSSetup."Doctor Item Journal Batch";
                            ItemJnlLine."Line No." := LineNo;
                            ItemJnlLine."Posting Date" := TODAY;
                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                            PharmLine.CALCFIELDS(PharmLine."Item No.");
                            ItemJnlLine."Document No." := PharmLine."Treatment No." + ':' + PharmLine."Item No.";
                            ItemJnlLine."Item No." := PharmLine."Item No.";
                            ItemJnlLine.VALIDATE(ItemJnlLine."Item No.");
                            ItemJnlLine."Location Code" := HMSSetup."Doctor Room";
                            ItemJnlLine.VALIDATE(ItemJnlLine."Location Code");
                            ItemJnlLine.Quantity := Rec."Injection Quantity";
                            ItemJnlLine.VALIDATE(ItemJnlLine.Quantity);
                            ItemJnlLine."Unit of Measure Code" := Rec."Injection Unit of Measure";
                            ItemJnlLine.VALIDATE(ItemJnlLine."Unit of Measure Code");
                            ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                            ItemJnlLine.INSERT();
                            PharmLine.Posted := TRUE;
                            PharmLine.MODIFY;
                            LineNo := LineNo + 1;
                        /*Update the treatment lines*/
                        UNTIL PharmLine.NEXT = 0;
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine);


                    END;

                end;
            }
        }
    }

    var
        HMSSetup: Record "HMS-Setup";
        LineNo: Integer;
        ItemJnlLine: Record 83;
        PharmLine: Record "HMS-Treatment Form Injection";
}

