page 54869 "HMS-Observation Form Dressing"
{
    PageType = ListPart;
    SourceTable = "HMS-Observation Dressings";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Process No."; Rec."Process No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
                            ItemJnlLine."Unit of Measure Code" := PharmLine."Unit of Measure";
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
        PharmLine: Record "HMS-Observation Dressings";
        LineNo: Integer;
        ItemJnlLine: Record 83;
}

