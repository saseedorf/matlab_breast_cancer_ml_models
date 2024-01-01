clc; close all; clear all;
%read the csv file "death.csv"
%death = readtable('death.csv','PreserveVariableNames',true);
death = readtable('death.csv');
death.birth_date = cellfun(@str2double, death.birth_date);

%read the csv file "recovered.csv"
%survived  = readtable('recovered.csv','PreserveVariableNames',true);
survived  = readtable('recovered.csv');

%read the csv file "recovered.csv"
%treatment  = readtable('under treatment.csv','PreserveVariableNames',true);
treatment  = readtable('under treatment.csv');
treatment.marital_length = cellfun(@str2double, treatment.marital_length);
treatment.pregnency_experience = cellfun(@str2double, treatment.pregnency_experience);
treatment.giving_birth = cellfun(@str2double, treatment.giving_birth);
treatment.age_FirstGivingBirth = cellfun(@str2double, treatment.age_FirstGivingBirth);
treatment.abortion = cellfun(@str2double, treatment.abortion);


%merge both the csv files
data = vertcat(death,survived, treatment);

%extracting the variables and displaying them
variables = data.Properties.VariableNames;
disp("The variables are");
disp(variables);

%removing unwanted variables and updating the variables

% List of columns to remove
% columns_to_remove = {"x_patient_id","treatment_data","id_healthcenter","id_treatment_region","birth_date"};

% Remove unwanted columns
%data = removevars(data, columns_to_remove);
columns_to_remove = {'x_patient_id', 'treatment_data', 'id_healthcenter', 'id_treatment_region', 'birth_date'};

% Remove unwanted columns
data = removevars(data, columns_to_remove);

%data(:,[("patient_id"),("treatment_data"),("id_healthcenter"),("id_treatment_region"),("birth_date")])=[];
variables = data.Properties.VariableNames;


%% 
% to print the entire summary of the dataset
disp("Summary");
summary(data);
%%
%filling in the null values of the columns age_first_giving birth,
%pregnency_exp and giving_birth
%all these columns have the same null values in the same indices
index = find(isnan(data{:,'age_FirstGivingBirth'}));
%disp(index);
data1 = table2cell(data);
len = height(data);

% column 7: marital status; 4:age; 1:gender
for j=1:length(index)
    i = index(j);
    if((data1{i,7}==1) && (data1{i,4}>35) && (data1{i,1}==0))
       data(i:i,'age_FirstGivingBirth')={1};
       data(i:i,'pregnency_experience')={1};
       data(i:i,'giving_birth')={1};
    else
         data(i:i,'age_FirstGivingBirth')={0};
         data(i:i,'pregnency_experience')={0};
         data(i:i,'giving_birth')={0};
    end
end
%%

%filling null values for abortion
index_1 = find((isnan(data{:,'abortion'})));
%disp(index_1);
mode_abortion = mode(data{:,'abortion'});
for j=1:length(index_1)
    i = index_1(j);
    if((data1{i,1}==0) && data1{i,7}==1 )
        data{i,'abortion'} = mode_abortion;
    else
        data{i,'abortion'} = 0;
    end
end
%%
%filling in the nan values of marital_length 
index_2 = find((isnan(data{:,'marital_length'})));
%disp(index_2);

for j=1:length(index_2)
    i = index_2(j);
    if(data1{i,7}==1 && data1{i,4}>40)
        data{i,'marital_length'} = 1;
    else
        data{i,'marital_length'} = 0;
    end
end
%%
%filling in nan values for menopausal age 
index_3 = find((isnan(data{:,'menopausal_age'})));
%disp(index_3)
for j=1:length(index_3)
    i = index_3(j);
    if(data1{i,7}==1 && data1{i,4}<50 && data1{i,1}==0)
        data{i,'menopausal_age'} = 1;
    elseif(data1{i,7}==1 && data1{i,4}>=50 && data1{i,1}==0)
        data{i,'menopausal_age'} = 2;
    else
        data{i,'menopausal_age'} = 0;
    end
end

%%
%Measures of Scale
% numeric = data{:,['age','weight','thickness_tumor']};
% dx1 = max(numeric)-min(numeric);

numeric_columns = {'age', 'weight', 'thickness_tumor'};
numeric = data{:, numeric_columns};
dx1 = max(numeric)-min(numeric);

%std dev
dx2 = std(numeric);
%variance
dx3 = var(numeric);
%

%%
%outliers for the column "age"

%ma = max(table2array(data(:,"age")));
%mi = min(table2array(data(:,"age")));
%disp(mi);disp(ma);
outlier_age = find(isoutlier(data{:,'age'}));
mean_age = round(mean(data{:,'age'}));
%disp(mean_age);
for i = 1:len
    if(data1{i,4}<35)
        %disp(data(i,"age"));
        data{i,'age'} = mean_age;
       
    end
end
%%
%outliers for the column "weight"
outliers_weight = find(isoutlier(data{:,'weight'}));
mean_weight = round(mean(data{:,'weight'}));
%disp(mean_weight);
for i = 1:len
    if(data1{i,5}<30)
         %disp(data(i,"age"));
        data{i,'weight'} = mean_weight;
    end
end
%%
%outliers for the column "thickness_tumor"

outliers_thickness = find(isoutlier(data{:,'thickness_tumor'}));
%disp(length(outliers_thickness));
%no_outliers in this numerical_column
%%
%removing unwanted values based on the column "benign_malignant_cancer"

%disp(unique(data(:,"Benign_malignant_cancer")));
row = find(table2array(data(:,'Benign_malignant_cancer')) == 2);

while((length(row))>0)
    data(row(1),:)=[];
    row = find(table2array(data(:,'Benign_malignant_cancer')) == 2);
end

%disp(unique(req_data(:,"Benign_malignant_cancer")));

%%
%shuffling the data for equal distribution of data while training the model
req_data  = data(randperm(size(data, 1)), :);
