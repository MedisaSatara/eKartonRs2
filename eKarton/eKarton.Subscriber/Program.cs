using EasyNetQ;
using eKarton.Model.Messages;
using Microsoft.VisualBasic;
// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");

var bus = RabbitHutch.CreateBus("host=localhost:5672");
await bus.PubSub.SubscribeAsync<DoktoriActivated>( "seminarski", msg => {
    Console.WriteLine($"Doktor activated: {msg.Doktor.Ime}");
});
Console.WriteLine("Listening for messages, press <return> key to close!");
Console.ReadLine();
