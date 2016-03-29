package producer

import org.springframework.amqp.rabbit.core.RabbitTemplate

class ProducerController {

    RabbitTemplate rabbitTemplate

    def sendMessage() {
        String msg = params.msg ?: 'Hello World!'

        rabbitTemplate.convertAndSend 'reverse', msg

        render "Message sent: ${msg}"
    }
}
