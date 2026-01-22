page 51871 "REG-ClosedFiles Card"
{
    Caption = 'REG-ClosedFiles Card';
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
                    Editable = false;
                }
                field(Region; Rec.Region)
                {
                    Caption = 'Region Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ToolTip = 'Specifies the value of the Closed By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ToolTip = 'Specifies the value of the Closed Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Version"; Rec."Version")
                {
                    ToolTip = 'Specifies the value of the Version field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Folios"; Rec."Total Folios")
                {
                    ToolTip = 'Specifies the value of the Total Folios field.';
                    ApplicationArea = All;
                    Editable = false;
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
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                RunObject = Page "REG-Doc Attach Details";

                RunPageLink = "No." = field("File Index");
            }
            action("Archive File")
            {
                ApplicationArea = All;
                Caption = 'Archive File';
                Image = ExportFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Archive this file';

                trigger OnAction()
                begin
                    Rec.SetRange("File Index", Rec."File Index");
                    Rec.SetRange(Version, Rec.Version);
                    if Rec.Find('-') then begin
                        Rec.Archived := true;
                        Rec."Archived By" := UserId;
                        Rec."Archived Date" := CurrentDateTime;
                        Rec.Modify;
                        Message('File Archived');
                    end;
                end;
            }
        }
    }
}
