# build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0.400 AS build-env
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0.400
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "FirstWebApps.dll"]