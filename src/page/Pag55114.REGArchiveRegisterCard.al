page 55114 "REG-ArchiveRegister Card"
{
    Caption = 'REG-ArchiveRegister Card';
    PageType = Card;
    SourceTable = "REG-Archives Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                }
                field("Version"; Rec."Version")
                {
                    ToolTip = 'Specifies the value of the Version field.';
                    ApplicationArea = All;
                }
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ref No."; Rec."Ref No.")
                {
                    ToolTip = 'Specifies the value of the Ref No. field.';
                    ApplicationArea = All;
                }
                field(Archived; Rec.Archived)
                {
                    ToolTip = 'Specifies the value of the Archived field.';
                    ApplicationArea = All;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ToolTip = 'Specifies the value of the Archived By field.';
                    ApplicationArea = All;
                }
                field("Archived Date"; Rec."Archived Date")
                {
                    ToolTip = 'Specifies the value of the Archived Date field.';
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'Folios';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach Destruction Certificate';

                RunObject = Page "REG-Doc Attach Details";

                RunPageLink = "No." = field("File Index");
            }
            action("Mark For Destruction")
            {
                ApplicationArea = All;
                Caption = 'Mark For Destruction';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Mark file for destruction';

                trigger OnAction()
                var
                    DocAttach: Record "REG-Doc Attachment";
                    Counter: Integer;
                begin
                    IF NOT DIALOG.CONFIRM('You are about to mark this file for destruction, continue?', TRUE) THEN
                        exit;
                    Rec.SetRange("File Index", Rec."File Index");
                    Rec.SetRange(Version, Rec.Version);
                    Rec.SetRange(Region, Rec.Region);
                    Rec.TestField("Ref No.");
                    if Rec.Find('-') then begin
                        Rec."Marked for Destruction" := true;
                        Rec."Marked Date" := CurrentDateTime;
                        Rec."Marked By" := UserId;
                        Rec.Modify;
                        DocAttach.setfilter(DocAttach."No.", '=%1', Rec."File Index");
                        if DocAttach.FindSet() then
                            repeat
                                DocAttach."Marked for Dist" := true;
                                DocAttach.Modify;
                                Counter += 1;
                            until DocAttach.Next = 0;
                        Message('File %1 with %2 Folios is Marked for destruction', Rec."File Index", Counter);
                    end;
                end;
            }
        }
    }

}
