report 50036 "FIN-Cheque Collectio  Report"
{
    ApplicationArea = All;
    Caption = 'FIN-Cheque Collection  Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ChequeCollection.rdl';
    dataset
    {
        dataitem(FINCheaqueCollectionHeader; "FIN-Cheaque Collection Header")
        {
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(CompInfoAddress1; CompInfo.Address)
            {
            }
            column(CompInfoPostCode; CompInfo."Post Code")
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(No; "No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            dataitem("FIN-Collection  Header Buffer"; "FIN-Collection  Header Buffer")
            {
                DataItemLink = No = field("No.");
                column(PV_No; "PV No") { }
                column(Cheque_No; "Cheque No") { }
                column(Payee_Name; "Payee Name") { }
                column(Amount; Amount) { }
                column(Date; Format(Date)) { }
                column(TIME; Format(TIME)) { }
                column(sn; sn) { }
                column(Received_By; "Received By") { }
                column(Remarks; Remarks) { }
                trigger OnAfterGetRecord()
                begin
                    sn := sn + 1;
                end;


            }
            trigger OnPreDataItem()
            begin
                CompInfo.get;
                CompInfo.CalcFields(Picture)
            end;




        }


    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        CompInfo: record 79;
        sn: Integer;

}
