page 54872 "HMS-Observation Form Injection"
{
    PageType = ListPart;
    SourceTable = "HMS-Observation Form Injection";

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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Injection Name"; Rec."Injection Name")
                {
                    ApplicationArea = All;
                }
                field("Item Unit Of Measure"; Rec."Item Unit Of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Injection Date"; Rec."Injection Date")
                {
                    ApplicationArea = All;
                }
                field("Injection Time"; Rec."Injection Time")
                {
                    ApplicationArea = All;
                }
                field("Injection Remarks"; Rec."Injection Remarks")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
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
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", HMSSetup."Observation Item Journal Temp");
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", HMSSetup."Observation Item Journal Batch");
                    IF ItemJnlLine.FIND('-') THEN ItemJnlLine.DELETEALL;
                    LineNo := 1000;
                    PharmLine.RESET;
                    PharmLine.SETRANGE(PharmLine."Observation No.", Rec."Observation No.");
                    PharmLine.SETRANGE(PharmLine.Posted, FALSE);
                    IF PharmLine.FIND('-') THEN BEGIN
                        REPEAT
                            ItemJnlLine.INIT;
                            ItemJnlLine."Journal Template Name" := HMSSetup."Observation Item Journal Temp";
                            ItemJnlLine."Journal Batch Name" := HMSSetup."Observation Item Journal Batch";
                            ItemJnlLine."Line No." := LineNo;
                            ItemJnlLine."Posting Date" := TODAY;
                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                            PharmLine.CALCFIELDS(PharmLine."Item No.");
                            ItemJnlLine."Document No." := PharmLine."Observation No." + ':' + PharmLine."Item No.";
                            ItemJnlLine."Item No." := PharmLine."Item No.";
                            ItemJnlLine.VALIDATE(ItemJnlLine."Item No.");
                            ItemJnlLine."Location Code" := HMSSetup."Observation Room";
                            ItemJnlLine.VALIDATE(ItemJnlLine."Location Code");
                            ItemJnlLine.Quantity := PharmLine.Quantity;
                            ItemJnlLine.VALIDATE(ItemJnlLine.Quantity);
                            ItemJnlLine."Unit of Measure Code" := PharmLine."Item Unit Of Measure";
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
        ItemJnlLine: Record 83;
        LineNo: Integer;
        PharmLine: Record "HMS-Observation Form Injection";
}

