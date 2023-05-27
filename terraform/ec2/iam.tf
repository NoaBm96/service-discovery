# Create an IAM role for the auto-join
resource "aws_iam_role" "consul_join" {
  name               = "consul_join"
  assume_role_policy = file("../templates/policies/assume-role.json")
}

# Create the policy
resource "aws_iam_policy" "consul_join" {
  name        = "consul_join"
  description = "Allows Consul nodes to describe instances for joining."
  policy      = file("../templates/policies/describe-instances.json")
}

# Attach the policy
resource "aws_iam_policy_attachment" "consul_join" {
  name       = "consul_join"
  roles      = [aws_iam_role.consul_join.name]
  policy_arn = aws_iam_policy.consul_join.arn
}

# Create the instance profile
resource "aws_iam_instance_profile" "consul_join" {
  name  = "consul_join"
  role = aws_iam_role.consul_join.name
}