page 51237 "CAT-Daily Menu"
{
    PageType = Document;
    SourceTable = "CAT-Daily Menu";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            field(MenuDate; MenuDate)
            {
                Caption = 'Menu Date';

                trigger OnValidate()
                begin
                    Rec."Menu Date" := MenuDate;
                    Rec.SETRANGE("Menu Date", MenuDate);
                end;
            }
            repeater(ewtr)
            {
                field(Menu; Rec.Menu)
                {
                    LookupPageID = "CAT-Menu List";

                    trigger OnValidate()
                    begin
                        Rec."Menu Date" := MenuDate;

                        // TESTFIELD("Menu Date");
                        MenuRec.SETRANGE(MenuRec.Code, Rec.Menu);
                        IF MenuRec.FIND('-') THEN BEGIN
                            Rec.Description := MenuRec.Description;
                            Rec.Units := MenuRec."Units Of Measure";
                            Rec."Menu Qty" := MenuRec.Quantity;
                            Rec."Unit Cost" := MenuRec.Amount;
                            Rec.Type := MenuRec.Type;
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Units; Rec.Units)
                {
                    Editable = false;
                }
                field("Menu Qty"; Rec."Menu Qty")
                {
                    Editable = false;
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    Editable = false;
                }
                field(Yield; Rec.Yield)
                {
                    Caption = 'Used Receipe';
                }
                field("Prod Qty"; Rec."Prod Qty")
                {
                    Caption = 'Yield';

                    trigger OnValidate()
                    begin
                        Rec."Total Qty" := Rec."Menu Qty" * Rec."Prod Qty";
                        Rec."Total Cost" := Rec."Total Qty" * Rec."Unit Cost";
                    end;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                }
                field("Campus Code"; Rec."Campus Code")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Post)
            {
                Caption = 'Post';
                action("Update Stock")
                {
                    Caption = 'Update Stock';

                    trigger OnAction()
                    begin
                        // Track The Last Entry
                        Rec.TESTFIELD("Campus Code");
                        Rec.TESTFIELD("Department Code");
                        IF ItemLedger.FIND('-') THEN BEGIN
                            ItemLedger.FINDLAST();
                            LastLedger := ItemLedger."Entry No.";
                        END;
                        // Post The Journal
                        "Post Inventory"();

                        // Update The Menu If Posting Was Done
                        IF ItemLedger.FIND('-') THEN BEGIN
                            IF LastLedger <> ItemLedger."Entry No." THEN BEGIN
                                Rec.SETRANGE("Menu Date", MenuDate);
                                IF Rec.FIND('-') THEN BEGIN
                                    REPEAT
                                        Rec."Remaining Qty" := Rec."Total Qty";
                                        Rec."produced By" := USERID;
                                        Rec.Posted := TRUE;
                                        Rec."Posted Date" := TODAY;
                                        Rec.MODIFY;
                                    UNTIL Rec.NEXT = 0;
                                END;
                            END;
                        END;
                    end;
                }
                action("Update Stock / Print Menu")
                {
                    Caption = 'Update Stock / Print Menu';

                    trigger OnAction()
                    begin
                        // Track The Last Entry
                        IF ItemLedger.FIND('-') THEN BEGIN
                            ItemLedger.FINDLAST();
                            LastLedger := ItemLedger."Entry No.";
                        END;
                        // Post The Journal
                        "Post Inventory"();

                        // Print Menu
                        Rec.SETRANGE("Menu Date", Rec."Menu Date");
                        REPORT.RUN(51161, FALSE, FALSE, Rec);

                        // Update The Menu If Posting Was Done
                        IF ItemLedger.FIND('-') THEN BEGIN
                            IF LastLedger <> ItemLedger."Entry No." THEN BEGIN
                                Rec."produced By" := USERID;
                                Rec.Posted := TRUE;
                                Rec."Posted Date" := TODAY;
                                Rec.MODIFY;
                            END;
                        END;
                    end;
                }
                action("Preview Menu")
                {
                    Caption = 'Preview Menu';

                    trigger OnAction()
                    begin
                        Rec.SETRANGE("Menu Date", Rec."Menu Date");
                        REPORT.RUN(51161, TRUE, TRUE, Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Get Left Overs")
            {
                Caption = 'Get Left Overs';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PAGE.RUN(39005757);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MenuDate := Rec."Menu Date";
    end;

    trigger OnOpenPage()
    begin
        MenuDate := TODAY;
    end;

    var
        MenuDate: Date;
        MenuRec: Record "CAT-Food Menu";
        Item: Record "Item";
        ITMJnl: Record "Item Journal Line";
        GenSetUp: Record "General Ledger Setup";
        "Line No": Integer;
        MenuLine: Record "CAT-Food Menu Line";
        str: Code[10];
        ItemLedger: Record "Item Ledger Entry";
        LastLedger: Integer;

    procedure "Post Inventory"()
    begin
        // Test Items To Be posted
        str := '';
        Rec.SETRANGE("Menu Date", MenuDate);
        Rec.SETFILTER(Menu, '<>%1', str);
        IF Rec.FIND('-') THEN BEGIN
        END
        ELSE BEGIN
            ERROR('There is Nothing To Be Posted Make Sure You Have Entered The Menu Date')
        END;
        Rec.TESTFIELD("Prod Qty");

        // Clean The Items Journal Line

        GenSetUp.GET();
        ITMJnl.SETRANGE(ITMJnl."Journal Template Name", GenSetUp."Item Template");
        ITMJnl.SETRANGE(ITMJnl."Journal Batch Name", GenSetUp."Item Batch");
        IF ITMJnl.FIND('-') THEN BEGIN
            REPEAT
                ITMJnl.DELETE;
            UNTIL ITMJnl.NEXT = 0;
        END;

        // Populate The Journal Line
        "Line No" := 10000;
        IF Rec.FIND('-') THEN BEGIN
            REPEAT
                MenuLine.SETRANGE(MenuLine.Menu, Rec.Menu);
                MenuLine.SETRANGE(MenuLine.Type, Rec.Type);
                IF MenuLine.FIND('-') THEN BEGIN
                    REPEAT
                        ITMJnl.INIT();
                        ITMJnl."Journal Template Name" := GenSetUp."Item Template";
                        ITMJnl."Journal Batch Name" := GenSetUp."Item Batch";
                        ITMJnl."Line No." := "Line No";
                        ITMJnl."Posting Date" := MenuDate;
                        ITMJnl."Entry Type" := ITMJnl."Entry Type"::"Negative Adjmt.";
                        ITMJnl.Quantity := Rec."Total Qty";
                        ITMJnl."Unit Cost" := Rec."Unit Cost";
                        ITMJnl."Unit Amount" := Rec."Unit Cost";
                        ITMJnl.Amount := Rec."Total Cost";
                        ITMJnl."Location Code" := MenuLine.Location;
                        ITMJnl."Gen. Prod. Posting Group" := 'CATERING';
                        ITMJnl."Gen. Bus. Posting Group" := 'LOCAL';
                        ITMJnl."Item No." := MenuLine."Item No";
                        ITMJnl.Description := MenuLine.Description;
                        ITMJnl."Document No." := FORMAT(Rec."Menu Date") + ' ' + Rec.Menu;
                        ITMJnl.VALIDATE(ITMJnl.Quantity);
                        ITMJnl."Shortcut Dimension 1 Code" := Rec."Campus Code";
                        ITMJnl."Shortcut Dimension 2 Code" := Rec."Department Code";
                        ITMJnl.INSERT(TRUE);
                        "Line No" := "Line No" + 10000;
                    UNTIL ITMJnl.NEXT = 0;
                END;
            UNTIL Rec.NEXT = 0;
        END;

        ITMJnl.SETRANGE(ITMJnl."Journal Template Name", GenSetUp."Item Template");
        ITMJnl.SETRANGE(ITMJnl."Journal Batch Name", GenSetUp."Item Batch");
        IF ITMJnl.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ITMJnl)
        END;
        //MESSAGE('Inventory Updated Successfully');
    end;

    local procedure MenuOnAfterInput(var Text: Text[1024])
    begin
        MenuDate := Rec."Menu Date";
    end;
}

