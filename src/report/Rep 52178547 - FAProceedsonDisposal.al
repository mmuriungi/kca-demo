report 52178547 "FA Proceeds on Disposal"
{
    Caption = 'FA Proceeds on Disposal';
    RDLCLayout = './Layouts/FA Proceeds on Disposal.rdl';
    DefaultLayout = rdlc;
    dataset
    {
        dataitem(FALedgerEntry; "FA Ledger Entry")
        {
            DataItemTableView = where("FA Posting Type" = filter('Proceeds on Disposal'));
            column(FANo; "FA No.")
            {
            }
            column(FAPostingType; "FA Posting Type")
            {
            }
            
            column(DocumentNo; "Document No.")
            {
            }
            column(Amount; Amount * -1)
            {
            }
            column(FAPostingDate; Format("FA Posting Date"))
            {
            }
            column(DepreciationBookCode; "Depreciation Book Code")
            {
            }
            column(CompInfoName; CompInfo.Name)
            {

            }
            column(CompInfoPicture; CompInfo.Picture)
            {

            }
            column(CompInfoAddress; CompInfo.Address)
            {

            }
            column(CompInfoPhone; CompInfo."Phone No.")
            {

            }
            column(CompInfoEmail; CompInfo."E-Mail")
            {

            }
            column(CompInfoWebPage; CompInfo."Home Page")
            {

            }
            column(seq; seq)
            {

            }
            column(FromDate; Format(FromDate))
            {
            }
            column(ToDate; Format(ToDate))
            {
            }
            dataitem("Fixed Asset"; "Fixed Asset")
            {
                DataItemLink = "No." = field("FA No.");
                column("AssetNo"; "No.")
                {
                }
                column("FADescription"; Description)
                {
                }
                column("VehicleRegistrationNo"; "Registration No.")
                {
                }
            }
            trigger OnPreDataItem()
            begin

                seq := 0;
                FALedgerEntry.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                PeriodText := STRSUBSTNO(Text000, FORMAT(FromDate, 0, 4), FORMAT(ToDate, 0, 4));
            end;

            trigger OnAfterGetRecord()
            begin
                seq += 1;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(From_Date; FromDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'From Date';
                    }
                    field(TO_Date; ToDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'To Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    var
    begin
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        seq: Integer;
         PeriodText: Text[100];
        Text000: Label 'From %1 To %2';
        FromDate: Date;
        ToDate: Date;
}
