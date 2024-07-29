page 55115 "REG-MarkedforDest"
{
    ApplicationArea = All;
    Caption = 'To be destroyed';
    PageType = List;
    SourceTable = "REG-Archives Register";
    UsageCategory = Administration;
    // SourceTableView = where("Marked for Destruction" = const(true), "Destroyed Date" = filter(= 0D));
    //PromotedActionCategories = 'New,Process,Reports,Navigation';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                }
                field("Marked Date"; Rec."Marked Date")
                {
                    ToolTip = 'Specifies the value of the Marked Date field.';
                    ApplicationArea = All;
                }
                field("Version"; Rec."Version")
                {
                    ToolTip = 'Specifies the value of the Version field.';
                    ApplicationArea = All;
                }
                field("Total Folios"; Rec."Total Folios")
                {
                    ToolTip = 'Specifies the value of the Total Folios field.';
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
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
            action("Destroy File")
            {
                ApplicationArea = All;
                Caption = 'Destroy File';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach Destruction Certificate';
                trigger OnAction()
                var
                    DocAttach: Record "REG-Doc Attachment";
                    Counter: Integer;
                begin
                    IF NOT DIALOG.CONFIRM('You are about to delete all documents in this file, please note that this action is irreversible, continue?', TRUE) THEN
                        exit;
                    Rec.SetRange("File Index", Rec."File Index");
                    Rec.SetRange(Version, Rec.Version);
                    Rec.SetRange(Region, Rec.Region);
                    //Rec.TestField("Ref No.");
                    if Rec.Find('-') then begin
                        Rec."Destroyed By" := UserId;
                        Rec."Destroyed Date" := CurrentDateTime;
                        Rec.Modify;
                        DocAttach.setfilter(DocAttach."No.", '=%1', Rec."File Index");
                        if DocAttach.FindSet() then
                            repeat
                                DocAttach."Marked for Dist" := true;
                                DocAttach.Delete();
                                Counter += 1;
                            until DocAttach.Next = 0;
                        Message('All documents in this file has been permanently deleted');
                    end;
                end;
            }
        }
    }
}
