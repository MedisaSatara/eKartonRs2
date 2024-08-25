FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["eKarton.Subscriber/eKarton.Subscriber.csproj", "eKarton.Subscriber/"]
RUN dotnet restore "eKarton.Subscriber/eKarton.Subscriber.csproj"
COPY . .
WORKDIR "/src/eKarton.Subscriber"
RUN dotnet build "eKarton.Subscriber.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "eKarton.Subscriber.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "eKarton.Subscriber.dll"]